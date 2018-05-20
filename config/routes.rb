Rails.application.routes.draw do
  resources :reviews, except: [:index, :new]
  root 'items#index'
  get 'order/:id' => 'order#show'
  post 'order/create' => 'order#create'

  get 'cart/' => 'cart#show'
  post 'cart/add_item' => 'cart#add_item'
  post 'cart/update_item' => 'cart#update_item'
  post 'cart/remove_item/:item_id' => 'cart#remove_item'

  get "/login" => "users#login_form"
  post "/login" => "users#attempt_login"
  post "/logout" => "users#logout"
  resources :users
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
