Rails.application.routes.draw do
  root 'posts#index'

  resources :posts do
    resources :comments
  end

  resources :posts do
    resources :likes, module: :posts
  end
  
  resources :comments do
    resources :likes, module: :comments
  end
  
  # Route to follow/unfollow that is tied to a specific user
  resources :users do
    member do
      get 'follow', to: 'follows#create'
      delete 'unfollow', to: 'follows#destroy'
    end
  end

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

end
