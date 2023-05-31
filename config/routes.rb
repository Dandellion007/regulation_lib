Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/route_not_found'
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

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  match '*unmatched', to: 'errors#route_not_found', via: :all
end
