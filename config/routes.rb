Rails.application.routes.draw do
  get 'microposts/new'

  get 'microposts/show'

  get 'sessions/new'

  get 'users/new'

  get 'users/show'
  get '/login',to:'sessions#new'
  post '/login',to:'sessions#create'
  delete '/logout',to:'sessions#destroy'
  get '/signup',to:'users#new'
  post '/signup',to:'users#create'

  resources :microposts, only: [:create,:destroy]
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :password_resets,only: [:new, :create, :edit, :update]
  resources :account_activations,only: [:edit]
  resources :relationships,only: [:create, :destroy]
  root 'microposts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
