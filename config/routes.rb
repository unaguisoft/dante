Rails.application.routes.draw do
  root 'main#home'
  resources :user_sessions, only: [:new, :create]

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

end
