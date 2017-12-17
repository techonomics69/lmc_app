Rails.application.routes.draw do
  get 'sessions/new'
	root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/membership', to: 'static_pages#membership'
  get '/application', to: 'members#new'
  post '/application', to: 'members#create'
  get '/login', to: 'static_pages#membership'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  
  resources :members do
    member do
      get 'emergency_contact', to: 'emergency_contact#edit'
      patch 'emergency_contact', to: 'emergency_contact#update'
      get 'meets', to: 'meets#edit'
      patch 'meets', to: 'meets#update'
    end
  end
  namespace :committee do
    get 'past_meets', to: 'meets#past'
    resources :meets
    resources :members do
      collection do
        get :edit_multiple#, to: 'members#index'
        post :edit_multiple 
        patch :update_multiple
        get :edit_role
        patch :update_role
      end
    end
  end
end
