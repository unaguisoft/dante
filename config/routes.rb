Rails.application.routes.draw do

  root 'main#home'

  # -- ADMIN --------------------------------------
  scope '/admin' do
    resources :user_sessions, only: [:new, :create]

    put 'photos/:id', to: 'photos#update'

    resources :properties do
      get 'upload_photos', to: 'properties#upload_photos', on: :member
      match 'photos', via: [:post, :patch], to: 'photos#create'
    end

    resources :investments do
      get 'upload_investment_photos', to: 'investments#upload_investment_photos', on: :member
      match 'investment_photos', via: [:post, :patch], to: 'investment_photos#create'
    end

    resources :features, only: [:new, :edit, :create, :index, :update, :destroy]
    resources :cities, only: [:new, :edit, :create, :index, :update, :destroy]
    resources :owners do
      get :search, on: :collection
    end

    resources :photos, only: [:destroy]
    resources :investment_photos, only: [:destroy]
    resources :users
  end


  get 'test_map', to: 'main#test_map', as: :test_map
  # -- PUBLIC --------------------------------------
  get 'propiedades', to: 'main#properties', as: :properties_for_web
  get 'propiedad/:id', to: 'main#property_details', as: :property_details
  get 'inversion/:id', to: 'main#investment_details', as: :investment_details
  get 'contacto', to: 'main#contact', as: :contact
  post 'propiedad/:id/enviar_consulta', to: 'main#send_question', as: :send_question
  post 'enviar_contacto', to: 'main#send_contact', as: :send_contact
  get  'tasacion', to: 'main#valuation', as: :valuation
  post 'enviar_tasacion', to: 'main#send_valuation', as: :send_valuation

  get 'login', to: 'user_sessions#new', as: :login
  post 'logout', to: 'user_sessions#destroy', as: :logout

end
