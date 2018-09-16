Rails.application.routes.draw do
  # get '/users/:nickname/posts' => "posts#index"
  # get '/users/:nickname/posts/new' => "posts#new"
  # get '/users/:nickname/posts/:post_id' => "posts#show"
  # get '/posts/new' => "posts#new"
  root 'top#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users do
    resources :posts
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
