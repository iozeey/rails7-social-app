Rails.application.routes.draw do
  resources :posts
  resources :groups do
    collection do
      get :created_by_me
    end
  end
  resources :group_users

  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root to: "home#index" 
end
