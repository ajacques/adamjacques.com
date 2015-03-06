require 'rack-proxy'

class BeaconProxy < Rack::Proxy
  def rewrite_env(env)
    request = Rack::Request.new(env)
    #@backend = URI.parse(Rails.application.appconfig.analytics['beacon_url'])
    env["HTTP_HOST"] = "metrics.technowizardry.net"
    puts env.inspect
    env
  end
end