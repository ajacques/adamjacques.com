class ContactController < ApplicationController
	def create_mail
	end

	def send_mail
		ContactMailer.user_contact(params[:name], params[:email], params[:subject], request.remote_ip, params[:message]).deliver

		redirect_to :controller => 'home', :action => 'resume'
	end
end