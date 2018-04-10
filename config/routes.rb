Rails.application.routes.draw do
  root to: 'users#index'
  resources :users, except: [:new, :edit]
end
