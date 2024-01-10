Rails.application.routes.draw do

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  authenticated :user do
    root to: 'dashboard#index', as: :user_root
  end

  namespace :admin do
    root to: "dashboard#index"
    resources :seasons, only: [:index, :create, :show, :destroy] do
      get "week/:week_id", to: "seasons#week", as: "week"
      patch "week/:week_id", to: "seasons#update_week", as: "week_update"
    end
  end

  resources :users, only: [:index] do
    member do
      resources :pools, only: [:index, :show], controller: "user_pools", as: "user_pools"
    end
  end

  resources :pools do
    member do
      delete "/remove_user/:user_id", to: "pools#remove_user", as: "remove_user"
      post "/add_user", to: "pools#add_user", as: "add_user"
    end
  end

  devise_for :users

  root to: "welcome#index"
end
