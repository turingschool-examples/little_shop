Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'
  resources :merchants do
    resources :items, only: [:index, :new, :create]
    end
    resources :items, only: [:index, :show, :edit, :update, :destroy] do
      resources :reviews, expect: :index
    end
    get '/cart', to: 'cart#show'
    get "/items/:id", to: 'reviews#index'
    patch '/cart/:item_id', to: 'cart#decrease_count'
    patch '/cart/:item_id/add', to: 'cart#increase_count'
    post '/cart/:item_id', to: 'cart#add_item'
    delete '/cart/:item_id', to: 'cart#remove_item'
    delete '/cart', to: 'cart#destroy'

  end
