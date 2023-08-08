FROM ruby:3.2.2-bookworm AS base

FROM base AS prereq

RUN echo 'gem: --no-document' > /etc/gemrc

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -

RUN apt-get update
RUN apt-get install -qy libmariadb3 ruby-dev nodejs build-essential \
    libmariadb-dev libsqlite3-dev libffi-dev yarn
RUN gem install bundler

WORKDIR /rails-app

FROM prereq AS npm

ADD package.json /rails-app
ADD yarn.lock /rails-app

RUN yarn install

FROM prereq AS prep

ADD Gemfile /rails-app
ADD Gemfile.lock /rails-app

RUN bundle config set without 'test development' \
  && bundle install

COPY --from=npm /rails-app/node_modules /rails-app/node_modules

ADD . /rails-app

# Generate compiled assets + manifests
FROM prep as finalprep

RUN SKIP_YARN_INSTALL=true RAILS_ENV=assets rake javascript:build

RUN rm -rf test tmp/* log/* node_modules app/{assets,javascript}
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

FROM base

RUN apt-get update \
  && apt-get install -qy --no-install-recommends nginx libxml2 libmariadb3 ca-certificates \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
  && rm -rf /var/cache/* /root \
  && adduser -u 9999 -H -h /rails-app -S www-data \
  && mkdir /var/lib/nginx/body \
  && chown www-data:www-data /var/lib/nginx /usr/share/nginx/

COPY --from=finalprep /usr/local/bundle /usr/local/bundle
COPY --from=finalprep /rails-app /rails-app
WORKDIR /rails-app

EXPOSE 8080 8081
