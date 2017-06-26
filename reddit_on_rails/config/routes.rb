Rails.application.routes.draw do
  get 'posts/show'

  # get 'sessions/new'

  # get 'sessions/create'
  #
  # get 'sessions/destroy'
  resources :users, only: [:new, :create]
  resources :subs, only: [:index, :show, :new, :create, :edit, :update]
  resources :posts, only: [:show, :new, :create, :edit, :update, :destroy]

  resource :session, only: [:new, :create, :destroy]


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
