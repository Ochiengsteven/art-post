# routes.rb

Rails.application.routes.draw do
  devise_for :users
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create] do
      resources :comments, only: [:new, :create]
      resources :likes, only: [:create]
    end
  end

  resources :posts, only: [:index, :show]

  get "up" => "rails/health#show", as: :rails_health_check
end
