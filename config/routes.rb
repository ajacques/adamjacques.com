ResumeWebsite::Application.routes.draw do
  get '(.:format)' => 'resume#resume', as: :index
  get 'contact_me' => 'contact#create_mail'
  post 'send_mail' => 'contact#send_mail'
  get 'ping' => 'health#ping'
  mount BeaconProxy.new, at: '/monitor'
end
