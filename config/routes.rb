Rails.application.routes.draw do
  get 'sessions/new'

	root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/membership', to: 'static_pages#membership'
  get '/help', to: 'static_pages#help'
  get '/application', to: 'members#new'
  post '/application', to: 'members#create'
  get '/login', to: 'static_pages#membership'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :members
end
