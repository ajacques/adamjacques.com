FROM ruby:3.2.2-bookworm AS base

FROM base AS prereq

RUN echo 'gem: --no-document' > /etc/gemrc

RUN apt-get update
RUN apt-get install -qy libmariadb3 ruby-dev build-essential \
    libmariadb-dev libsqlite3-dev libffi-dev
RUN gem install bundler

WORKDIR /rails-app

FROM node:21.2-bookworm-slim AS npm

WORKDIR /rails-app
ADD package.json /rails-app
ADD yarn.lock /rails-app

RUN yarn install

ADD . /rails-app

RUN RAILS_ENV=assets yarn build

FROM prereq AS prep

ADD Gemfile /rails-app
ADD Gemfile.lock /rails-app

RUN bundle config set without 'test development' \
  && bundle install

ADD . /rails-app

# This stage is responsible for slimming down the container and setting permissions
FROM prep as finalprep

COPY --from=npm /rails-app/public/assets /rails-app/public/assets

# All files/folders should be owned by root but readable by www-data
RUN find . -type f -exec chmod 444 {} \;
RUN find . -type d -print -exec chmod 555 {} \;
RUN chown -R 9999:9999 tmp
RUN chmod 755 db
RUN find bin -type f -exec chmod +x {} \;
RUN find tmp -type d -print -exec chmod 755 {} \;

# Final Phase
RUN bundle config set without 'test development assets' \
  && bundle install \
  && bundle clean --force

RUN ["/bin/bash", "-c", "rm -rf test tmp/* log/* node_modules app/assets app/javascript *.js yarn* *.json"]

RUN mkdir -p app/assets/config && touch app/assets/config/manifest.js

RUN rm -rf /usr/local/bundle/cache

FROM ruby:3.2.2-slim-bookworm

RUN apt-get update \
  && apt-get install -qy --no-install-recommends nginx libxml2 libmariadb3 ca-certificates \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
  && rm -rf /var/cache/* /root \
  && adduser -u 9999 -H -h /rails-app -S www-data \
  && mkdir /var/lib/nginx/body \
  && chown www-data:www-data /var/lib/nginx /usr/share/nginx/ \
  && rm /var/log/nginx/access.log /var/log/nginx/error.log \
  && ln -s /dev/stdout /var/log/nginx/access.log \
  && ln -s /dev/stderr /var/log/nginx/error.log

COPY --from=finalprep /usr/local/bundle /usr/local/bundle
COPY --from=finalprep /rails-app /rails-app
WORKDIR /rails-app

EXPOSE 8080 8081
