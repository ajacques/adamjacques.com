FROM alpine:3.5

ADD . /rails-app
WORKDIR /rails-app
RUN export BUILD_PKGS="ruby-dev build-base mariadb-dev nodejs libxml2-dev linux-headers" \
  && apk --update --upgrade add ruby ruby-json ca-certificates libxml2 mariadb-client-libs ruby-io-console ruby-bigdecimal $BUILD_PKGS \

  && gem install -N bundler \
  && env bundle install --without test development \

# Generate compiled assets + manifests
  && RAILS_ENV=assets rake assets:precompile \

# Uninstall development headers/packages
  && apk del $BUILD_PKGS \
  && find / -type f -iname \*.apk-new -delete \
  && rm -rf /var/cache/apk/* \

  && rm -rf /var/lib/gems/*/cache/* ~/.gem /var/cache/* /root tmp/* \

  && addgroup -g 9999 -S www-data && adduser -u 9999 -H -h /rails-app -S www-data \

# All files/folders should be owned by root by readable by www-data
  && find . -type f -print -exec chmod 444 {} \; \
  && find . -type d -print -exec chmod 555 {} \; \

  && chown -R www-data:www-data tmp \
  && chmod 755 db && find tmp -type d -print -exec chmod 755 {} \; \
  && find bin -type f -print -exec chmod 544 {} \;
ENV RAILS_ENV=production
USER www-data
EXPOSE 8080
ENTRYPOINT ["/usr/bin/ruby", "/rails-app/bin/bundle", "exec"]
CMD ["/usr/bin/unicorn", "-o", "0.0.0.0", "-p", "8080", "--no-default-middleware"]
