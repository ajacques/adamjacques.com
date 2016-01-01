require 'rack-proxy'

class BeaconProxy < Rack::Proxy
  def rewrite_env(env)
    request = Rack::Request.new(env)
    uri = URI.parse(Rails.application.appconfig.analytics['beacon_url'])
    env['HTTP_HOST'] = uri.host
    env
  end
end
