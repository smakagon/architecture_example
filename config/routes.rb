Rails.application.routes.draw do
  root to: 'users#index'
  resources :users, except: %i[new edit]
end
