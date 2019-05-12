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
  gem 'rubocop'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails'

  gem 'uglifier'
end

group :assets, :development do
  gem 'sprockets-es6'
end

group :development do
  gem 'sqlite3'
end

gem 'aws-sdk-s3', require: false
gem 'etc' # Alpine Linux does not include this by default
gem 'nokogiri', '>= 1.8.1'
gem 'unicorn'
