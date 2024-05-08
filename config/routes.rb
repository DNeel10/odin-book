Rails.application.routes.draw do
  root 'posts#index'

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  resources :posts do
    resources :comments
    resources :likes, module: :posts
  end
  
  resources :comments do
    resources :likes, module: :comments
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
