FROM ubuntu:15.04

RUN /usr/bin/apt-get update && /usr/bin/apt-get install -qy --no-install-recommends make g++ ruby ruby-dev libmysqlclient-dev
RUN gem install bundler --no-ri --no-rdoc
ADD Gemfile /rails-app/Gemfile
ADD Gemfile.lock /rails-app/Gemfile.lock
WORKDIR /rails-app
RUN /usr/bin/env bundle install --without assets development test
RUN /usr/bin/apt-get remove -qy --purge ruby-dev g++ make patch gcc libmysqlclient-dev && /usr/bin/apt-get -qy autoremove
RUN /bin/rm -rf /var/lib/gems/2.1.0/cache /var/cache/ /var/lib/apt/lists/
ADD . /rails-app
RUN find public -mindepth 1 -not -name 'assets' -not -name 'manifest-*.json' -delete
RUN chown -R www-data:www-data Gemfile.lock db tmp
USER www-data
EXPOSE 8080
CMD bundle exec unicorn -p 8080
