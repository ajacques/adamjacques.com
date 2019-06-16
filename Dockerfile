FROM alpine:3.9 as build

RUN mkdir /rails-app
ADD Gemfile /rails-app
ADD Gemfile.lock /rails-app
WORKDIR /rails-app
RUN export BUILD_PKGS="ruby-dev build-base mariadb-dev nodejs libxml2-dev linux-headers ca-certificates libffi-dev" \
  && apk --no-cache --upgrade add ruby ruby-json ruby-etc libxml2 mariadb-client ruby-io-console ruby-bigdecimal $BUILD_PKGS \
  && echo 'gem: --no-document' > /etc/gemrc \
  && gem install -N bundler \
  && env bundle install --frozen --without test development

ADD . /rails-app
# Generate compiled assets + manifests
RUN RAILS_ENV=assets rake assets:precompile \
  && rm -rf app/assets test tmp/* .bundle/cache log/* \
# All files/folders should be owned by root but readable by www-data
  && find . -type f -exec chmod 444 {} \; \
  && find . -type d -print -exec chmod 555 {} \; \
  && chown -R 9999:9999 tmp \
  && chmod 755 db \
  && find tmp -type d -print -exec chmod 755 {} \; \
  && find bin runit -type f -print -exec chmod 555 {} \; \
  && mkdir -m 755 runit/nginx/supervise runit/rails/supervise

FROM alpine:3.9

COPY --from=build /rails-app /rails-app
WORKDIR /rails-app
RUN export BUILD_PKGS="ruby-dev build-base mariadb-dev libxml2-dev linux-headers ca-certificates libffi-dev" \
  && apk --no-cache --upgrade add ruby runit nginx ruby-json ruby-etc libxml2 mariadb-client mariadb-connector-c ruby-io-console ruby-bigdecimal $BUILD_PKGS \
  && gem install -N bundler \
  && echo 'gem: --no-document' > /etc/gemrc \
  && env bundle install --frozen --with production \
# Uninstall development headers/packages
  && apk del $BUILD_PKGS \
  && find / -type f -iname \*.apk-new -delete \
  && rm -rf /var/cache/apk/* /lib/apk/db \
  && rm -rf /usr/lib/ruby/gems/*/cache ~/.gem /var/cache/* /root \
  && adduser -u 9999 -H -h /rails-app -S www-data

ENV RAILS_ENV=production
EXPOSE 8080
EXPOSE 8081
CMD ["/sbin/runsvdir", "/rails-app/runit"]
