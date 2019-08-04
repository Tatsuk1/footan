Rails.application.routes.draw do
  root to: 'toppages#index'
  
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  resources :users
  
  resources :shops, only: [:index, :show, :create] do
    resources :posts, only: [:new, :create]
  end
  resources :posts, except: [:new, :create]
end
