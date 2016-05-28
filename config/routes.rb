Rails.application.routes.draw do
  resources :instances

  namespace :api, defaults: { format: :json } do
    resource :readings, only: [:create]
  end

  root 'instances#index'
end