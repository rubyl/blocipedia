Rails.application.routes.draw do
  resources :wikis

  root 'welcome#index'
  devise_for :users
end
