Rails.application.routes.draw do
  get 'user/admin_user'
  devise_for :users
  get "up" => "rails/health#show", as: :rails_health_check
  
  # action cable
  mount ActionCable.server => '/cable'

  resources :products do
    member do
      match '/destroy', action: :destroy, via: [:get, :delete], as: :destroy
    end

    resources :comments, only: [:create, :destroy]
  end

  resources :activity_logs

  resources :carts do
    member do
      # actions new, add product, remove product
      get '/new_cart', to: 'carts#new', as: :new_cart # Cart
      match '/add_to_cart/product_id', action: :add_to_cart, via: [:get, :post], as: :add_to_cart # CartItem, Cart, and Product
      match '/remove_product_from_cart/:product_id', action: :remove_product_from_cart, via: [:get, :delete], as: :remove_product_from_cart
      
      # update quantity, and downgrade quantity(if > 1)
      match '/update_quantity/:product_id', action: :update_quantity, via: [:get, :patch], as: :update_quantity
      match '/downgrade_quantity/:product_id', action: :downgrade_quantity, via: [:get, :patch], as: :downgrade_quantity
      
      # checkout and make empty again cart of user BEFORE completed the order.
      get '/checkout', to: 'carts#checkout', as: :checkout # CartItem
      match 'destroy_all_items', via: [:get, :post]
    end
  end
  
  match '/admin_user', to: 'users#admin_user', via: [:get, :post]
  
  resources :home do
    member do
      get '/history/', to: 'home#history', as: :history
      get '/user/', to: 'home#user', as: :user
    end
  end

  namespace :admin do
    root "home#index"
  end

  # Defines the root path route ("/")
  root "home#about"
end
