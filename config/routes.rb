Rails.application.routes.draw do

  root 'main#home'

  scope '/admin' do
    resources :user_sessions, only: [:new, :create]

    resources :properties do
      patch 'photos', to: 'photos#create' # Al estar en un form manda con patch
    end
    
    resources :features, only: [:new, :edit, :create, :index, :update, :destroy]
    resources :cities, only: [:new, :edit, :create, :index, :update, :destroy]
    resources :owners do
      get :search, on: :collection
    end
    
    resources :photos, only: [:destroy]
    resources :users
  end

  get 'propiedades', to: 'main#properties', as: :properties_for_web

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

end
