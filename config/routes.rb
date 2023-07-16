Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'pages#home'

  devise_for :users, controllers: {
    confirmations: 'users/confirmations'
  }

  resources :users, only: %i[index show] do
    member do
      get 'verify'
    end
    collection do
      post 'search'
    end
  end

  resources :services, only: %i[index show]
end
