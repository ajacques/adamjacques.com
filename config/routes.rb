ResumeWebsite::Application.routes.draw do
  get '(.:format)' => 'resume#resume', as: :index
  get 'ping' => 'health#ping'
end
