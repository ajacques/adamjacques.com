ResumeWebsite::Application.routes.draw do
	get '(.:format)' => 'home#resume', as: :index
	get 'contact_me' => 'contact#create_mail'
	post 'send_mail' => 'contact#send_mail'
end
