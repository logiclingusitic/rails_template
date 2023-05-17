Rails.application.routes.draw do

  root "v1/client/products#index"
  namespace :v1 do
    namespace :client do

      resources :orders
      resources :carts
      resources :cart_items
      resources :products
      resources :users

      get '/login', to: 'sessions#new', as: :login
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy', as: :logout
      get '/user/cart', to: 'carts#show', as: 'user_cart'

    end
  end

end
