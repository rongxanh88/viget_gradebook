Rails.application.routes.draw do
  root to: "home#index"

  post '/login', to: 'sessions#create'
  delete '/login', to: 'sessions#destroy'

  namespace :student do
    resources :dashboard, only: [:index]
  end

  namespace :admin do
    resources :dashboard, only: [:index]
  end
end
