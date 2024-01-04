Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products do
    member do
      delete '/destroy', to: 'products#destroy', as: :destroy
    end
  end

  get '/about', to: 'home#about', as: :about
  # get :about, on: :collection

  # Defines the root path route ("/")
  root "products#index"
end
