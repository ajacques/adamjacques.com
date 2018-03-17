class ContactController < ApplicationController
  def send_mail
    ContactMailer.user_contact(
      name: params[:name],
      email: params[:email],
      src_ip: request.remote_ip,
      message: params[:message]
    ).deliver

    redirect_to controller: 'home', action: 'resume'
    expires_in 5.minutes, public: true
  end
end
