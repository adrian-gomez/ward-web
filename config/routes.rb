Rails.application.routes.draw do
  resources :instances

  root 'instances#index'
end