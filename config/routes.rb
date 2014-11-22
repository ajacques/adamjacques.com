ResumeWebsite::Application.routes.draw do
	root :to => 'home#resume'
	get 'home' => 'home#resume'
	get 'contact_me' => 'contact#create_mail'
	post 'send_mail' => 'contact#send_mail'
	get 'key_geopoints' => 'geospatial#key_points'

	scope 'admin' do
		get 'edit' => 'admin#edit'
		get 'key_point' => 'admin#keypoint_delete', :method => :delete
		get 'key_point' => 'admin#keypoint_create', :method => :create
	end
end
