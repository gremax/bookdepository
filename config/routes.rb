Rails.application.routes.draw do
  root to: 'store#index'
  resources :books
  get    'signin',  to: 'session#new',     as: 'signin'
  post   'signin',  to: 'session#create'
  delete 'signout', to: 'session#destroy'
  get    'signup',  to: 'users#new',       as: 'signup'
  post   'signup',  to: 'users#create',    as: 'users'
end
