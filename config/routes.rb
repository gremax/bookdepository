Rails.application.routes.draw do
  root to: 'books#index'
  resources :books
  get  'signup', to: 'users#new',    as: 'signup'
  post 'signup', to: 'users#create', as: 'users'
end
