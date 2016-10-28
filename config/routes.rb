Rails.application.routes.draw do

  root 'main#home'

  scope '/admin' do
    resources :user_sessions, only: [:new, :create]

    resources :properties do
      get 'upload_photos', to: 'properties#upload_photos', on: :member
      match 'photos', via: [:post, :patch], to: 'photos#create'
    end

    resources :features, only: [:new, :edit, :create, :index, :update, :destroy]
    resources :cities, only: [:new, :edit, :create, :index, :update, :destroy]
    resources :owners do
      get :search, on: :collection
    end

    resources :photos, only: [:destroy]
    resources :users
  end

  # PUBLIC
  get 'propiedades', to: 'main#properties', as: :properties_for_web
  get 'propiedad/:id', to: 'main#property_details', as: :property_details

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

end
