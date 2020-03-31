Rails.application.routes.draw do
  root 'posts#index'

  get 'my_posts' => 'posts#my_posts'

  devise_for :users

  get 'search' => 'posts#search'

  resources :posts do
    resources :comments
  end

  resources :categories
end
