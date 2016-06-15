Rails.application.routes.draw do

  root 'static_pages#home'
  
  resources :user_sessions, only: [:new, :create, :destroy]
  resources :users
  resources :user_tenders
  resources :password_resets, :only => [ :new, :create, :edit, :update ]

  get '/activate/:activation_code', to: 'activation#create', as: 'activation'

  match '/login',    to: 'user_sessions#new',        via: 'get'
  match '/logout',   to: 'user_sessions#destroy',    via: 'delete'
  match '/reg',      to: 'users#new',                via: [:get, :post]
  match '/archive',  to: 'static_pages#archive',     via: 'get'
  match '/my_archive',  to: 'user_tenders#my_archive',     via: 'get'

  namespace :admin do
    root 'tenders#index'
    
    resources :managers
    resources :manager_sessions, only: [:new, :create, :destroy]
    resources :tenders do
      post :new, on: :member
      post :decide, on: :member
      patch :close_without_winner, on: :member
      patch :start_second_stage, on: :member
    end
    resources :categories
    resources :users
    
    match '/signup',   to: 'managers#new',                     via: [:get, :post]
    match '/signin',   to: 'manager_sessions#new',             via: 'get'
    match '/signout',  to: 'manager_sessions#destroy',         via: 'delete'

    require 'sidekiq/web'
    require 'admin_constraint'
    mount Sidekiq::Web => '/stats', :constraints => AdminConstraint.new
  end
end
