Rails.application.routes.draw do
  get 'cart/show'

  get "/login" => "users#login_form"
  post "/login" => "users#attempt_login"
  post "/logout" => "users#logout"
  resources :users
  resources :items
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
