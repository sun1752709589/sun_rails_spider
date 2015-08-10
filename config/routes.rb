Rails.application.routes.draw do
  resources :articles
  resources :companies
  root 'articles#index'
  resources :birt_test
end
