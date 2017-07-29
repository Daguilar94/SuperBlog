Rails.application.routes.draw do

  resources :posts, only: [:index, :show] 

  resources :users, except: [:index, :create, :new, :show] do
    resources :posts
  end

  devise_for :users, path: 'auth'
  root 'posts#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
