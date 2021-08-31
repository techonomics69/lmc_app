# frozen_string_literal: true

Rails.application.routes.draw do
  root 'static_pages#home'
  get 'password_resets/new'
  get 'password_resets/edit'
  get 'sessions/new'
  get '/home', to: 'static_pages#home'
  get '/membership', to: 'static_pages#membership'
  get '/application', to: 'members#new'
  post '/application', to: 'members#create'
  get '/benefits', to: 'static_pages#benefits'
  get '/pay', to: 'static_pages#pay'
  get '/handbook', to: 'static_pages#handbook'
  get '/handbook_download', to: 'static_pages#handbook_download'
  get '/meets', to: 'static_pages#meets'
  get '/calendar', to: 'static_pages#calendar'
  get '/meetslist', to: 'static_pages#ical_feed'
  get '/booking', to: 'static_pages#booking'
  get '/galleries', to: 'static_pages#galleries'
  get '/help', to: 'static_pages#help'
  get '/committee', to: 'static_pages#the_committee'
  get '/history', to: 'static_pages#history'
  get '/cae_amos', to: 'static_pages#cae_amos'
  get '/archives', to: 'static_pages#archives'
  get '/reports', to: 'static_pages#reports'
  get '/contact', to: 'static_pages#contact'
  get '/links', to: 'static_pages#links'
  get '/privacy-policy', to: 'static_pages#privacy_policy'
  get '/login', to: 'static_pages#membership'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  patch '/update_attendee_status/:meet_id/:member_id', to: 'attendees#update_status', as: 'update_attendee_status'

  resources :password_resets, only: %i[new create edit update]

  resources :members do
    member do
      get 'emergency_contact', to: 'emergency_contact#edit'
      patch 'emergency_contact', to: 'emergency_contact#update'
      get 'meets', to: 'meets#edit'
      patch 'meets', to: 'meets#update'
      get 'attendees', to: 'attendees#index'
      patch 'attendees', to: 'attendees#update'
      delete 'attendees', to: 'attendees#destroy'
      get 'sign_up/:meet_id', to: 'attendees#new', as: :new_attendee
      post 'sign_up/:meet_id', to: 'attendees#create'
      patch 'email_subscribe', to: 'members#email_subscribe'
    end
  end

  namespace :committee do
    resources :emails
    get '/mailer/email_preview(/:id(.:format))', to: 'emails#email_preview', as: 'email_preview'
    get '/mailer/send_email(/:id(.:format))', to: 'emails#send_email', as: 'send_email'
    get 'past_meets', to: 'meets#past'
    resources :meets
    resources :attendees
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
