class ContactController < ApplicationController
  def create_mail
  end

  def send_mail
    target = Rails.application.config.user.email
    subject = Rails.application.config.user.subject
    ContactMailer.user_contact(target, "website@#{request.host}", subject, params[:name], params[:email], params[:subject], request.remote_ip, params[:message]).deliver

    redirect_to controller: 'home', action: 'resume'
    expires_in 5.minutes, public: true
  end
end
