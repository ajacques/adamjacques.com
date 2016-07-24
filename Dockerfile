FROM ubuntu:16.04

COPY . /rails-app
WORKDIR /rails-app
RUN /usr/bin/apt-get update \
  && /usr/bin/apt-get install -qy --no-install-recommends make g++ ruby ruby-dev libmysqlclient20 libmysqlclient-dev zlib1g-dev patch \
  && gem install bundler --no-ri --no-rdoc \
  && /usr/bin/env bundle install --without development \
  && RAILS_ENV=assets rake assets:precompile \
  && /usr/bin/apt-get remove -qy --purge ruby-dev g++ make patch libmysqlclient-dev zlib1g-dev patch \
  && /usr/bin/apt-get -qy autoremove \
  && /usr/bin/dpkg --purge $(dpkg --get-selections | grep deinstall | cut -f1) \
  && /bin/rm -rf /var/lib/gems/2.3.0/cache /var/cache/ /var/lib/apt/lists /var/log/* tmp/* \
  && chown -R www-data:www-data Gemfile.lock tmp
USER www-data
EXPOSE 8080
CMD bundle exec unicorn -p 8080
