Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/merchants', to: 'merchants#index'
  get '/merchants/new', to: 'merchants#new'
  get '/merchants/:id', to: 'merchants#show'
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id/edit', to: 'merchants#edit'
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'

  get '/items', to: 'items#index'
  get '/merchants/:merchant_id/items', to: 'items#index'
  get '/items/:id', to: 'items#show'
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  post '/merchants/:merchant_id/items', to: 'items#create'
  get '/items/:id/edit', to: 'items#edit'
  patch '/items/:id', to: 'items#update'
  delete '/items/:id', to: 'items#destroy'

  post '/cart/:item_id', to: 'cart#add_item', as: 'add_cart'
  get '/cart', to: 'cart#show', as: 'cart'
  delete '/cart', to: 'cart#destroy', as: 'empty_cart'
  put '/cart/:item_id', to: 'cart#remove_item', as: 'remove_item'
  patch '/cart/:item_id', to: 'cart#update', as: 'update_cart'

  get '/orders/new', to: 'orders#new'
  post '/orders', to: 'orders#create'
  get '/orders/:id', to: 'orders#show'

  get "/items/:item_id/reviews/new", to: 'reviews#new', as: 'reviews_new_path'
  post '/items/:item_id', to: 'reviews#create'
  delete '/items/:item_id/reviews/:id', to: 'reviews#destroy'
  get '/items/:item_id/reviews/:id/edit', to: 'reviews#edit'
  patch '/items/:item_id/reviews/:id', to: 'reviews#update'
end
