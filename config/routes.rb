Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  devise_for :users

  resources :documents do
    member do
      get 'raw_edit'
      post 'raw_update'
      get 'archive'
    end
  end

  get 'archive_index', to: 'documents#archive_index'

  get "home/index"
  root to: "documents#index"
end
