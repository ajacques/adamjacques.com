class ContactMailer < ActionMailer::Base
	default :from => 'www@adamjacques.com'

	def user_contact(name, email, subject, ip, message)
		@params = {:name => name, :email => email, :subject => subject, :message => message}
		@ipaddr = ip
		@date = Time.now.utc

		headers 'Reply-To' => email,
				'X-Mailer' => 'Ruby'

		mail :to => 'adam@adamjacques.com', :subject => 'AdamJacques.name Inquiry' do |format|
			format.text
		end
	end
end