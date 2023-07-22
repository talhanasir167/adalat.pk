Rails.application.routes.draw do
  ActiveAdmin.routes(self)
  root to: 'pages#home'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }

  resources :users, only: %i[index show] do
    member do
      get 'verify'
    end
    collection do
      post 'search'
    end
  end

  get '/about', to: 'pages#about', as: 'about_page'
  get '/contact', to: 'pages#contact', as: 'contact'
  get '/faqs', to: 'pages#faqs', as: 'faqs_page'

  resources :services, only: %i[index show]
end
