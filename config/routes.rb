Rails.application.routes.draw do
  resources :user_stocks
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"
  get "my_stocks", to: "stock#index"
  post "my_stocks", to: "stock#add"
  get "search_stock", to: "stock#search"
end
