ResumeWebsite::Application.routes.draw do
  root :to => 'home#resume'
  match 'contact_me' => 'contact#create_mail'
end