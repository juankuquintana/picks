# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  accept_email_pattern = %r{[^/]+}

  # Home pages
  # -------------------------------------------------

  get 'home' => 'home#index'

  # Leagues pages
  # -------------------------------------------------

  resources :leagues, only: %i[index] do
    collection do
      get ':league_name', to: 'leagues#show', as: 'league'
      get ':league_name/:round', to: 'leagues#show', as: 'league_round'
    end
  end

  # User session pages
  # -------------------------------------------------

  get 'login'                   => 'user_sessions#new'
  get 'logout'                  => 'user_sessions#destroy'
  get 'auth/:provider/callback' => 'user_sessions#google_login_callback'
  get 'auth/failure'            => 'user_sessions#failure'

  # User signup pages
  # -------------------------------------------------

  get 'signup' => 'user_signups#new'

  # Public site pages
  # -------------------------------------------------

  get '/'        => 'site#index'
  get '/privacy' => 'site#privacy'

  # Admin pages
  # -------------------------------------------------

  namespace :admin do
    root to: 'home#index'
    resources :accounts, id: accept_email_pattern, only: %i[index show]
    resources :orders, only: %i[index show]
    resources :leagues, only: %i[index show]
    resources :teams, only: %i[index show]
    resources :fixtures, only: %i[index show]
    resources :pools, only: %i[index]
    resources :bets, only: %i[index]
    resources :countries, only: %i[index]
    resources :users, id: accept_email_pattern, only: %i[index show]

    mount Flipper::UI.app(Flipper) => '/flipper', constraints: CanAccessFeatureFlag
    mount Sidekiq::Web => '/sidekiq', constraints: CanAccessSidekiq
  end

  root to: 'site#index'
end
