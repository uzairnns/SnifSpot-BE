Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post '/login', to: 'users#login'
  resources :spots, only: [:create, :update, :index, :show]
  resources :reviews, only: [:create, :update]
  resources :users, only: [:create ]
end
