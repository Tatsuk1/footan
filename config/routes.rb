Rails.application.routes.draw do
  root to: 'toppages#index'

  get 'random_toppage', to: 'toppages#random'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
  
  get 'signup', to: 'users#new'
  get 'random', to: 'shops#random'
  resources :users do
    member do
      get :likes
      get :like_shops
      get :random_shops
    end
  end    
  resources :admins, only: [:index, :destroy]
  resources :shops, only: [:index, :show, :create] do
    resources :posts, only: [:new, :create]
  end
  resources :posts, except: [:new, :create]
  resources :favorites, only: [:create, :destroy]
  resources :favorite_shops, only: [:create, :destroy]
end
