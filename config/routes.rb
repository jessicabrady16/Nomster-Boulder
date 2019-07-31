# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  root 'places#index'
  resources :places
end
