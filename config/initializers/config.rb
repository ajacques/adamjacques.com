require 'ostruct'

Rails.application.config.user = OpenStruct.new({
  name: ENV['RESUME_NAME'],
  email: ENV['RESUME_EMAIL'],
  subject: ENV['RESUME_EMAIL_SUBJECT']
})

if ENV.key? 'PIWIK_JS'
  Rails.application.config.analytics = {
    'tracker_script' => ENV['PIWIK_JS'],
    'beacon_url' => ENV['PIWIK_BEACON']
  }
end

if ENV.key? 'EMAIL_HOST'
  ActionMailer::Base.delivery_method = :smtp
  ActionMailer::Base.smtp_settings = {
    address: ENV['EMAIL_HOST'],
    port: ENV['EMAIL_PORT'] || 587
  }
end
