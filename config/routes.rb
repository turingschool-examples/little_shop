Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html


  resources :items, only: [:index, :show, :edit, :update, :destroy]

  resources :merchants do
    resources :items, only: [:index, :new, :create]
  end

  resources :orders, only: [:new, :create, :show]

  post '/cart/:item_id', to: 'cart#add_item', as: 'add_cart'
  get '/cart', to: 'cart#show', as: 'cart'
  delete '/cart', to: 'cart#destroy', as: 'empty_cart'
  put '/cart/:item_id', to: 'cart#remove_item', as: 'remove_item'
  patch '/cart/:item_id', to: 'cart#update', as: 'update_cart'

  get "/items/:item_id/reviews/new", to: 'reviews#new', as: 'reviews_new_path'
  post '/items/:item_id', to: 'reviews#create'
  delete '/items/:item_id/reviews/:id', to: 'reviews#destroy'
  get '/items/:item_id/reviews/:id/edit', to: 'reviews#edit'
  patch '/items/:item_id/reviews/:id', to: 'reviews#update'
end
