Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check

  resources :products do
    member do
      delete '/destroy', to: 'products#destroy', as: :destroy
    end
  end

  resources :activity_logs, only: [:index] do
    collection do
      get 'search'
    end
  end

  resources :carts do
    member do
      get '/new_cart', to: 'carts#new', as: :new_cart # Cart
      match '/add_to_cart/product_id', action: :add_to_cart, via: [:get, :post], as: :add_to_cart # CartItem, Cart, and Product
    end
  end
  get '/about', to: 'home#about', as: :about
  # get :about, on: :collection

  # Defines the root path route ("/")
  root "products#index"
end
