source 'https://rubygems.org'

gem 'rails'

gem 'haml'
gem 'haml-rails'

group :production do
  gem 'mysql2'
end

gem 'tzinfo-data'

gem 'webpacker'

group :test, :development do
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'

  gem 'uglifier'
end

gem 'aws-sdk-s3', require: false
gem 'webrick', require: false # AWS S3 SDK depends on this

group :assets, :development do
  gem 'libv8', platform: :ruby
  gem 'sprockets-es6'
  gem 'therubyracer', platform: :ruby
end

group :development do
  #gem 'debase', require: false
  #gem 'ruby-debug-ide', require: false
  gem 'sqlite3'
end

gem 'nokogiri', '>= 1.8.1'
gem 'unicorn'

gem 'sentry-ruby'
gem 'sentry-rails'

gem 'simple-rss'

