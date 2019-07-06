Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :items
  resources :merchants
  resources :orders

  put '/cart', to: 'carts#remove_item'
  patch '/cart/decrease', to: 'carts#decrease_item'
  patch '/cart/increase', to: 'carts#increase_item'
  resource :cart, except: :put

  get '/merchants/:merchant_id/items', to: 'items#index'
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  post '/merchants/:merchant_id/items', to: 'items#create'
end
