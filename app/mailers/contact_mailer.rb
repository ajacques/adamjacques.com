class ContactMailer < ActionMailer::Base
  def user_contact(name:, email:, ip:, message:)
    subject = Rails.application.config.user.subject
    @params = { name: name, email: email, subject: subject, message: message }
    @ipaddr = ip
    @date = Time.now.utc

    headers 'Reply-To' => email,
            'X-Mailer' => 'Ruby'

    mail to: Rails.application.config.user.email, subject: subject, &:text
  end
end
