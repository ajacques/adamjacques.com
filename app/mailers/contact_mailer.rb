class ContactMailer < ActionMailer::Base
	def user_contact(target, from, email_subject, name, email, subject, ip, message)
		@params = {:name => name, :email => email, :subject => subject, :message => message}
		@ipaddr = ip
		@date = Time.now.utc

		headers 'Reply-To' => email,
				'X-Mailer' => 'Ruby'

		mail :to => target, :from => from, :subject => email_subject do |format|
			format.text
		end
	end
end