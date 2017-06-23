Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:new, :create, :show, :destroy]
  resource :session, only: [:new, :create, :destroy]

  resources :bands, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
    resources :albums, only: [:new]
  end

  resources :albums, only: [:show, :create, :edit, :update, :destroy] do
      resources :tracks, only: [:new]
    end

  resources :tracks, only: [:show, :create, :edit, :update, :destroy]
end
