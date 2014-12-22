FROM ubuntu:14.04

RUN /usr/bin/apt-get update && /usr/bin/apt-get install -qy ruby1.9.1 bundler thin libmysqlclient-dev nodejs
ADD . /rails-app
WORKDIR /rails-app
RUN /bin/bash -c -l 'bundle install --without development test assets'
COPY config/database.yml /rails-app/config/database.yml
CMD thin -R config.ru -S /var/run/thin/$SITE_NAME.sock -u www-data -g www-data start