Rails.application.routes.draw do

  get '/addresses/find_address', to: 'addresses#find_address', as: 'query_for_address'
  resources :addresses
  devise_for :users
  root 'pages#home'

  
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
