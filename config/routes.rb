Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root "welcome#index"
  get "my_stocks", to: "stock#index"
  get "search_stock", to: "stock#search"
end
