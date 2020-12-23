FROM ruby:2.7-buster AS prereq

RUN echo 'gem: --no-document' > /etc/gemrc

RUN apt-get update
RUN apt-get install -qy libmariadb3 ruby-dev nodejs build-essential libmariadb-dev libsqlite-dev libffi-dev

WORKDIR /rails-app
ADD Gemfile /rails-app
ADD Gemfile.lock /rails-app

# Development is a special target that installs
FROM prereq AS development

RUN bundle install

FROM prereq AS prep

RUN bundle config set without 'test development' \
  && bundle install

ADD . /rails-app

# Generate compiled assets + manifests
RUN export RAILS_ENV=assets \
  && rake assets:precompile \
  && rm -rf test tmp/* log/* \
# All files/folders should be owned by root but readable by www-data
  && find . -type f -exec chmod 444 {} \; \
  && find . -type d -print -exec chmod 555 {} \; \
  && chown -R 9999:9999 tmp \
  && chmod 755 db \
  && find tmp -type d -print -exec chmod 755 {} \; \
  && find bin runit -type f -print -exec chmod 555 {} \; \
  && mkdir -m 755 runit/nginx/supervise runit/rails/supervise \
  && rails tmp:create

# Final Phase
RUN bundle config set without 'test development assets' \
  && bundle install \
  && bundle clean --force

RUN rm -rf /usr/local/bundle/cache

FROM ruby:2.7-slim-buster

RUN apt-get update \
  && apt-get install -qy --no-install-recommends runit nginx libxml2 libmariadb3 ca-certificates \
# Uninstall development headers/packages
  && apt-get clean autoclean \
  && apt-get autoremove --yes \
  && rm -rf /var/lib/{apt,dpkg,cache,log}/ \
  && rm -rf /var/cache/* /root \
  && adduser -u 9999 -H -h /rails-app -S www-data \
  && mkdir /var/lib/nginx/body \
  && chown www-data:www-data /var/lib/nginx /usr/share/nginx/

COPY --from=prep /usr/local/bundle /usr/local/bundle
COPY --from=prep /rails-app /rails-app
WORKDIR /rails-app

EXPOSE 8080 8081
CMD ["/usr/bin/runsvdir", "/rails-app/runit"]
