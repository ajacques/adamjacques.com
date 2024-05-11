source 'https://rubygems.org'

gem 'actionpack'
gem 'actionview'
gem 'activemodel'
gem 'activerecord'
gem 'activesupport'
gem 'railties'
gem 'sprockets-rails'
gem 'unicorn'

gem 'haml'
gem 'haml-rails'

group :production do
  gem 'mysql2'
end

gem 'tzinfo-data'

group :test, :development do
  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rake', require: false

  gem 'webmock', '~> 3.14'
end

gem 'aws-sdk-s3', require: false
gem 'webrick', require: false # AWS S3 SDK depends on this

group :assets, :development do
  gem 'sqlite3', '~> 1.4'
end

gem 'sentry-ruby'
gem 'sentry-rails'

gem 'faraday'

# Telemetry
gem 'opentelemetry-sdk'
gem 'opentelemetry-propagator-b3'
gem 'opentelemetry-exporter-otlp'
gem 'opentelemetry-instrumentation-faraday'
gem 'opentelemetry-instrumentation-mysql2'
gem 'opentelemetry-instrumentation-rails'
