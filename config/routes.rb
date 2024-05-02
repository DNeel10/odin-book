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

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

end
