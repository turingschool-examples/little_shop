Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/', to: 'merchants#index'

  get '/merchants', to: 'merchants#index', as: :merchants
  get '/merchants/new', to: 'merchants#new'
  get '/merchants/:id', to: 'merchants#show'
  post '/merchants', to: 'merchants#create'
  get '/merchants/:id/edit', to: 'merchants#edit'
  patch '/merchants/:id', to: 'merchants#update'
  delete '/merchants/:id', to: 'merchants#destroy'

  get '/items', to: 'items#index', as: :items
  get '/merchants/:merchant_id/items', to: 'items#index'
  get '/items/:id', to: 'items#show', as: :item
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  post '/merchants/:merchant_id/items', to: 'items#create'
  get '/items/:id/edit', to: 'items#edit'
  patch '/items/:id', to: 'items#update'
  delete '/items/:id', to: 'items#destroy'

  get '/cart', to: 'carts#index', as: :cart
  patch '/cart/:item_id', to: 'carts#add_item', as: :add_to_cart
  put '/cart/:item_id', to: 'carts#remove_item', as: :remove_from_cart
  delete '/cart', to: 'carts#destroy', as: :empty_cart

  get '/order/new', to: 'orders#new', as: :new_order
end
