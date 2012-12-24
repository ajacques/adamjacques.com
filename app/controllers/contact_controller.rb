class ContactController < ApplicationController
	def create_mail
	end

	def send_mail
		@params = params

		headers 'Reply-To' => params[:email],
				'X-Mailer' => 'Ruby'

		mail :to => 'adam@adrensoftware.com', :subject => 'AdamJacques.name Inquiry' do |format|
			format.text
		end
	end
end