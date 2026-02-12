FROM ruby:3.3-bookworm AS base

FROM base AS prereq

RUN echo 'gem: --no-document' > /etc/gemrc

RUN apt-get update \
 && apt-get install -qy --no-install-recommends libmariadb3 ruby-dev build-essential \
    libmariadb-dev libsqlite3-dev libffi-dev \
 && gem install bundler \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

WORKDIR /rails-app

# Copy gem files first for better cache utilization
COPY Gemfile Gemfile.lock ./
RUN bundle config set --local deployment 'true' \
 && bundle config set --local without 'test development assets' \
 && bundle install --jobs=4 --retry=3 \
 && bundle clean --force

FROM node:22-bookworm-slim AS npm

WORKDIR /rails-app
COPY package.json yarn.lock ./
RUN yarn install --frozen-lockfile --production=false

# Copy the rest of the application  
COPY . .

RUN RAILS_ENV=assets yarn build

FROM prereq AS prep

# Copy built assets from npm stage
COPY --from=npm /rails-app/public/assets /rails-app/public/assets
COPY --from=npm /rails-app /rails-app

# This stage is responsible for slimming down the container and setting permissions
FROM prep AS finalprep

# All files/folders should be owned by root but readable by www-data
RUN find . -type f -exec chmod 444 {} \; \
 && find . -type d -print -exec chmod 555 {} \; \
 && chown -R 9999:9999 tmp \
 && chmod 755 db \
 && find bin -type f -exec chmod +x {} \; \
 && find tmp -type d -print -exec chmod 755 {} \;

# Clean up unnecessary files
RUN rm -rf test tmp/* log/* node_modules app/assets app/javascript *.js yarn* *.json \
 && mkdir -p app/assets/config && touch app/assets/config/manifest.js \
 && rm -rf /usr/local/bundle/cache/rubygems.org/gems/.doc

FROM ruby:3.3-slim-bookworm

RUN apt-get update \
  && apt-get install -qy --no-install-recommends nginx libxml2 libmariadb3 ca-certificates \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/ /tmp/* /var/tmp/* \
  && adduser -u 9999 -H -h /rails-app -S www-data \
  && mkdir -p /var/lib/nginx/body \
  && chown www-data:www-data /var/lib/nginx /usr/share/nginx/ \
  && rm /var/log/nginx/access.log /var/log/nginx/error.log \
  && ln -s /dev/stdout /var/log/nginx/access.log \
  && ln -s /dev/stderr /var/log/nginx/error.log

# Copy only production gems and application
COPY --from=finalprep /usr/local/bundle /usr/local/bundle
COPY --from=finalprep /rails-app /rails-app

# Clean up bundle cache to reduce final image size
RUN rm -rf /usr/local/bundle/cache/rubygems.org/cache/*.gem \
 && find /usr/local/bundle/gems -name "*.c" -delete \
 && find /usr/local/bundle/gems -name "*.o" -delete

WORKDIR /rails-app

EXPOSE 8080 8081
