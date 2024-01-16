Rails.application.routes.draw do
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  # action cable
  mount ActionCable.server => '/cable'

  resources :products do
    member do
      delete '/destroy', to: 'products#destroy', as: :destroy
    end

    resources :comments, only: [:create, :destroy]
  end

  resources :activity_logs, only: [:index] do
    collection do
      get 'search'
    end
  end

  resources :carts do
    member do
      # actions new, add product, remove product, and update quantity, and downgrade quantity(if > 1)
      get '/new_cart', to: 'carts#new', as: :new_cart # Cart
      match '/add_to_cart/product_id', action: :add_to_cart, via: [:get, :post], as: :add_to_cart # CartItem, Cart, and Product
      match '/remove_product_from_cart/:product_id', action: :remove_product_from_cart, via: [:get, :delete], as: :remove_product_from_cart
      match '/update_quantity/:product_id', action: :update_quantity, via: [:get, :patch], as: :update_quantity
      match '/downgrade_quantity/:product_id', action: :update_quantity, via: [:get, :patch], as: :downgrade_quantity
      
      # checkout and make empty again cart of user BEFORE completed the order.
      get '/checkout', to: 'carts#checkout', as: :checkout # CartItem
      match 'destroy_all_items', via: [:get, :post]
    end
  end
  
  resources :home, only: [] do
    member do
      get '/history', to: 'home#history', as: :history
    end
    
    collection do
      # get 'about', to: 'home#about', as: :about_home
    end
  end

  # Defines the root path route ("/")
  root "products#index"
end
