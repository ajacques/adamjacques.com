class ContactMailer < ActionMailer::Base
  def user_contact(name:, email:, src_ip:, message:)
    user_config = Rails.application.config.user
    subject = user_config.subject
    @params = { name: name, email: email, subject: subject, message: message }
    @ipaddr = src_ip
    @date = Time.now.utc

    headers 'Reply-To' => email,
            'X-Mailer' => 'Ruby'

    mail to: user_config.email, subject: subject, &:text
  end
end
