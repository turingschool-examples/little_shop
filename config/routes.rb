Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :items
  resources :merchants

  resource :cart

  resource :cart, only: [:show] do
    put 'add/:item_id', to: 'cart#add', as: :add_to
  end

  get '/merchants/:merchant_id/items', to: 'items#index'
  get '/merchants/:merchant_id/items/new', to: 'items#new'
  post '/merchants/:merchant_id/items', to: 'items#create'
end
