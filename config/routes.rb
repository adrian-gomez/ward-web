Rails.application.routes.draw do
  get :dashboard,  controller: :dashboard, action: :index

  resources :instances do
    resources :readings, only: [:index], controller: 'instances/readings'
  end

  namespace :api, defaults: { format: :json } do
    resources :readings, only: [:create]
  end

  root 'dashboard#index'
end