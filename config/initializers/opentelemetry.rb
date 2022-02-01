require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/net_http'
require 'opentelemetry/instrumentation/mysql2'
require 'opentelemetry/instrumentation/rails'

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'ResumeWebsite'
  c.use_all() # enables all instrumentation!
end