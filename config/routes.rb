Rails.application.routes.draw do
  root 'posts#index'
  get 'my_posts' => 'posts#my_posts'

  resources :posts do
    resources :comments
  end

  devise_for :users
end
