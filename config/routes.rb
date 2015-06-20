Rails.application.routes.draw do
  root to: 'books#index'
  resources :books
  get  'signin', to: 'session#new',    as: 'signin'
  post 'signin', to: 'session#create'
  get  'signup', to: 'users#new',      as: 'signup'
  post 'signup', to: 'users#create',   as: 'users'
end
