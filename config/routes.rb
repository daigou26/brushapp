Rails.application.routes.draw do
  get 'privacy_policy' => "privacy_policy#index"
  get 'terms' => "terms#index"
  get '/users/:nickname/posts/new' => "posts#new"
  post '/users/:nickname/posts/new' => "posts#create"
  get '/users/:nickname/posts/:id/edit' => "posts#edit"
  patch '/users/:nickname/posts/:id/edit' => "posts#update"
  get '/users/:nickname/posts/:id/feedbacks' => "feedbacks#new"
  post '/users/:nickname/posts/:id/feedbacks' => "feedbacks#create"
  root 'top#index'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  resources :users, only: [] do
    resources :posts, only: [:show, :destroy]
    resources :notifications, only: [:index]
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
