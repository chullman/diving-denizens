Rails.application.routes.draw do

  get '/cart_items', to: 'pages#home', as: 'cart_items'
  get '/show_cart', to: 'cart_items#show_cart', as: 'show_cart'
  delete '/clear_cart', to: 'cart_items#clear_cart', as: 'clear_cart'
  post '/listings/:id', to: 'listings#add_to_cart', as: 'add_to_cart'
  resources :cart_items, except: [:new, :index, :edit, :update, :create, :show]
  resources :listings
  root 'pages#home'


  get '/addresses/find_address', to: 'addresses#find_address', as: 'query_for_address'
  get '/addresses', to: 'pages#home', as: 'addresses'
  get '/addresses/:id', to: 'pages#home', as: 'address'
  resources :addresses, except: [:index, :show]

  

  devise_for :users, controllers: { registrations: 'users/registrations' }
  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
