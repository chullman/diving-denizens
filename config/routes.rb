Rails.application.routes.draw do
  resources :addresses
  devise_for :users
  root 'pages#home'

  get '/addresses/new', to: 'addresses#find_address', as: 'query_for_address'
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
