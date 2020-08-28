FROM ruby:2.7-buster AS prereq

RUN apt-get update && apt-get install --no-install-recommends -qy nodejs
RUN echo 'gem: --no-document' > /etc/gemrc

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

FROM ruby:2.7-alpine3.12

RUN apk --no-cache --upgrade add runit nginx libxml2 mariadb-client mariadb-connector-c ca-certificates \
# Uninstall development headers/packages
  && find / -type f -iname \*.apk-new -delete \
  && rm -rf /var/cache/apk/* /lib/apk/db \
  && rm -rf /usr/lib/ruby/gems/*/cache ~/.gem /var/cache/* /root \
  && adduser -u 9999 -H -h /rails-app -S www-data

COPY --from=build /usr/local/bundle /usr/local/bundle
COPY --from=build /rails-app /rails-app
WORKDIR /rails-app

EXPOSE 8080 8081
CMD ["/sbin/runsvdir", "/rails-app/runit"]
