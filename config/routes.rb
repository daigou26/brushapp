Rails.application.routes.draw do
  get '/users/:nickname/posts/new' => "posts#new"
  post '/users/:nickname/posts/new' => "posts#create"
  get '/users/:nickname/posts/:id' => "feedbacks#new"
  post '/users/:nickname/posts/:id' => "feedbacks#create"
  root 'top#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: [] do
    resources :posts, only: [:new, :create, :destroy]
    resources :feedbacks, only: [:new, :create, :show]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
