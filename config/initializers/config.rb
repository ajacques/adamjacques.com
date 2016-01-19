require 'ostruct'

Rails.application.define_singleton_method("appconfig") {
  yaml = YAML.load_file("#{Rails.root}/config/configuration.yml")
  config = {}
  if yaml.is_a? Hash
    if yaml['default']
      config.merge!(yaml['default'])
    end
    if yaml[Rails.env]
      config.merge!(yaml[Rails.env])
    end
  end

  OpenStruct.new(config)
}

config = Rails.application.appconfig

if config.email_delivery
  config.email_delivery.each do |key, value|
    value.symbolize_keys! if value.respond_to?(:symbolize_keys)
    ActionMailer::Base.send("#{key}=", value)
  end
end

if config.secret_key
  Rails.application.config.secret_token = config.secret_key
end