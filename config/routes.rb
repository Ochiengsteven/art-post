# routes.rb

Rails.application.routes.draw do
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create]
  end

  resources :posts, only: [:index, :show]

  resources :posts do
    resources :comments, only: [:create], controller: 'comments'
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
