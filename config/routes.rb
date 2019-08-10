Rails.application.routes.draw do
  devise_for :users
  root 'places#index'
  resources :places do
    resources :comments, only: [:create, :destroy]
    resources :photos, only: [:create, :destroy]
  end
  
end
