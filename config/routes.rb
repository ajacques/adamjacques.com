ResumeWebsite::Application.routes.draw do
	get '(.:format)' => 'home#resume', as: :index
	get 'contact_me' => 'contact#create_mail'
	get 'metrics_ping' => 'home#monitor', as: :beacon
	post 'send_mail' => 'contact#send_mail'
end
