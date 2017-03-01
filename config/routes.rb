Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show]
  resources :sessions

  resources :posts
  resources :comments, only: [:create, :destroy]

  get "logout" => "sessions#destroy", :as => "logout"
  get "signin" => "sessions#new", :as => "sign_in"
  get "signup" => "users#new", :as => "sign_up"

  root 'posts#index'
end