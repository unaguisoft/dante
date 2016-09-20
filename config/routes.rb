Rails.application.routes.draw do

  root 'main#home'

  resources :user_sessions, only: [:new, :create]
  resources :features, only: [:new, :edit, :create, :index, :update, :destroy]
  resources :cities, only: [:new, :edit, :create, :index, :update, :destroy]
  resources :owners

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

end
