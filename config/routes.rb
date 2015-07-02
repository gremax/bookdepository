Rails.application.routes.draw do
  root to: 'store#index'
  resources :books
  resources :authors
  resources :categories
  resources :order_items, only: [:create, :update, :destroy]
  resource  :cart, only: :show
  get    'signin',  to: 'session#new',     as: 'signin'
  post   'signin',  to: 'session#create'
  delete 'signout', to: 'session#destroy'
  get    'signup',  to: 'users#new',       as: 'signup'
  post   'signup',  to: 'users#create',    as: 'users'
end
