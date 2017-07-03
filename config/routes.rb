Rails.application.routes.draw do
  devise_for :users
  root 'wikis#index'
  resources :users do
    member do
      post :downgrade
    end
  end
  resources :wikis
  resources :charges, only: [:new, :create]
  resources :wikis do
    resources :collaborators, only: [:new, :create, :destroy]
  end
end
