FROM ubuntu:16.04

COPY . /rails-app
WORKDIR /rails-app
RUN /usr/bin/apt-get update \
  && /usr/bin/apt-get install -qy --no-install-recommends make g++ ruby ruby-dev libmysqlclient20 libmysqlclient-dev zlib1g-dev patch \
  && gem install bundler --no-ri --no-rdoc \
  && /usr/bin/env bundle install --without assets development test \
  && /usr/bin/apt-get remove -qy --purge ruby-dev g++ make patch gcc libmysqlclient-dev zlib1g-dev patch \
  && /usr/bin/apt-get -qy autoremove \
  && /usr/bin/dpkg --purge $(dpkg --get-selections | grep deinstall | cut -f1) \
  && /bin/rm -rf /var/lib/gems/2.1.0/cache /var/cache/ /var/lib/apt/lists /var/log/* \
  && chown -R www-data:www-data Gemfile.lock tmp \
  && find public -mindepth 1 -not -name 'assets' -not -name 'manifest-*.json' -delete
USER www-data
EXPOSE 8080
CMD bundle exec unicorn -p 8080
