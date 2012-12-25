ResumeWebsite::Application.routes.draw do
  root :to => 'home#resume'
  match 'contact_me' => 'contact#create_mail'
  match 'send_mail' => 'contact#send_mail'
end