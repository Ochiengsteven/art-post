# routes.rb

Rails.application.routes.draw do
  devise_for :users, path: '', path_names: { sign_in: 'login', sign_out: 'logout' }
  root "users#index"

  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :show, :new, :create, :destroy] do
      resources :comments, only: [:new, :create, :destroy]
      resources :likes, only: [:create]
    end
  end

  resources :posts, only: [:index, :show, :destroy]

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index, :show] do
        resources :posts, only: [:index]
      end

      resources :posts do
        resources :comments, only: [:index, :create]
      end
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
