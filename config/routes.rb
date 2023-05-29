Rails.application.routes.draw do
  resources :documents do
    member do
      get 'raw_edit'
      post 'raw_update'
    end
  end

  get "home/index"
  root to: "home#index"
end
