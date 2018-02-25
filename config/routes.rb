Rails.application.routes.draw do
  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'
	root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/membership', to: 'static_pages#membership'
  get '/application', to: 'members#new'
  post '/application', to: 'members#create'
  get '/calendar', to: 'static_pages#calendar'
  get '/ical_feed', to: 'static_pages#ical_feed'
  get '/login', to: 'static_pages#membership'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  resources :password_resets, only: [:new, :create, :edit, :update]

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
        post :multiple 
        patch :update_multiple
        get :edit_role
        patch :update_role
        get :export_all, to: 'members#all'
        get :export_bmc, to: 'members#for_bmc'
        post :export_checked, to: 'members#checked'
        get :download_file, to: 'members#download_file'
      end
    end
  end
end
