Rails.application.config.content_security_policy do |policy|
  policy.default_src :none
  map = {
    script_src: %i[self],
    connect_src: []
  }
  policy.media_src :self
  policy.style_src :self

  if ENV.key? 'SENTRY_DSN'
    sentry_dsn = URI.parse(ENV['SENTRY_DSN'])
    map[:connect_src] << sentry_dsn.host
  end

  if Rails.application.config.respond_to? :analytics
    report_uri = URI.parse(Rails.application.config.analytics['beacon_url'])
    host = report_uri.hostname
    map[:script_src] << host
    map[:connect_src] << host
  end

  map.each do |key, value|
    policy.send(key, *value)
  end

  sentry_uri = ENV['SENTRY_REPORT_URI']
  if sentry_uri.present?
    # Specify URI for violation reports
    uri = URI.parse(sentry_uri)
    new_query_ar = URI.decode_www_form(String(uri.query))
    new_query_ar << ['sentry_environment', Rails.env]
    uri.query = URI.encode_www_form(new_query_ar)

    policy.report_uri uri.to_s
  end
end
