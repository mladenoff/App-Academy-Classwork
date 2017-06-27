Rails.application.routes.draw do
  root to: 'subs#index'

  resources :users, only: [:new, :create]
  resources :subs, only: [:index, :show, :new, :create, :edit, :update]
  resources :posts, only: [:show, :new, :create, :edit, :update, :destroy] do
    resources :comments, only: :new
  end
  resources :comments, only: [:create, :show]

  resource :session, only: [:new, :create, :destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
