Rails.application.routes.draw do
  get 'pages/home'
  root 'pages#home'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: 'users/registrations' }

  resources :posts do
    resources :comments, module: :posts
    resources :likes, only: [:create, :destroy], module: :posts
  end
  
  resources :comments do
    resources :comments, module: :comments
    resources :likes, only: [:create, :destroy], module: :comments
  end
  
  resources :users do
    # routes to follow and unfollow other users
    member do
      get 'follow', to: 'follows#create'
      delete 'unfollow', to: 'follows#destroy'
    end
    resource :profile, only: [:edit, :show, :update]
  end
end
