Rails.application.routes.draw do
	root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/application', to: 'members#new'
end
