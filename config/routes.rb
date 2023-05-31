Rails.application.routes.draw do
  resources :documents do
    member do
      get 'raw_edit'
      post 'raw_update'
      get 'archive'
    end
  end

  get 'archive_index', to: 'documents#archive_index'

  get "home/index"
  root to: "home#index"
end
