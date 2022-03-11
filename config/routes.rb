Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  root to: 'users#index'

  namespace :api do
    namespace :v1 do
      resources :users, only: %i[show] do
        resources :posts, only: %i[index] do
          resources :comments, only: %i[create index]
        end
      end
    end
  end

  resources :users, only: [] do
    member do
      get 'apitoken'
    end
  end

  resources :users, only: %i[show index] do
    resources :posts, only: %i[show index create new destroy]
  end

  resources :posts do
      resources :comments, only: %i[create new update destroy]
      resources :likes, only: %i[create] 
  end
end