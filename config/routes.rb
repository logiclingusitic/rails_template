Rails.application.routes.draw do


  namespace :v1 do
    namespace :client do

      resources :users

      get '/login', to: 'sessions#new', as: :login
      post '/login', to: 'sessions#create'
      delete '/logout', to: 'sessions#destroy', as: :logout


    end
  end

end
