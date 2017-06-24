Rails.application.routes.draw do
  resources :wikis
  resources :charges, only: [:new, :create]

  root 'welcome#index'
  devise_for :users
end
