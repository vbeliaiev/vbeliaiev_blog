Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: %i[new create show]
  resources :sessions

  resources :posts
  resources :comments, only: %i[create destroy]

  get "logout" => "sessions#destroy", :as => "logout"
  get "signin" => "sessions#new", :as => "sign_in"

  root 'posts#index'
end
