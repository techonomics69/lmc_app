Rails.application.routes.draw do
	root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/membership', to: 'static_pages#membership'
  get '/help', to: 'static_pages#help'
  get '/application', to: 'members#new'
  post '/application', to: 'members#create'
  resources :members
end
