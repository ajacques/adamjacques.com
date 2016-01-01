class ContactController < ApplicationController
  def create_mail
  end

  def send_mail
    target = Rails.application.appconfig.email
    subject = Rails.application.appconfig.email_subject
    ContactMailer.user_contact(target, "website@#{request.host}", subject, params[:name], params[:email], params[:subject], request.remote_ip, params[:message]).deliver

    redirect_to controller: 'home', action: 'resume'
  end
end
