Rails.application.routes.draw do
  resources :documents

  get "home/index"
  root to: "home#index"
end
