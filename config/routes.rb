Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'pages#home'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations'
  }

  resources :users, only: %i[show]
end
