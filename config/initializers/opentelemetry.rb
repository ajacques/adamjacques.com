require 'opentelemetry/sdk'
require 'opentelemetry/exporter/otlp'
require 'opentelemetry/instrumentation/mysql2'
require 'opentelemetry/instrumentation/rails'

instrumentation_config = {
  'OpenTelemetry::Instrumentation::ActionPack' => { enable_recognize_route: true },
}

OpenTelemetry::SDK.configure do |c|
  c.service_name = 'ResumeWebsite'
  c.use_all(instrumentation_config)
end

# Parent is NGINX
OpenTelemetry.tracer_provider.sampler = OpenTelemetry::SDK::Trace::Samplers.parent_based(root: OpenTelemetry::SDK::Trace::Samplers::ALWAYS_OFF)
