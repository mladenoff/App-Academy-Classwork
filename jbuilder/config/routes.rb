Rails.application.routes.draw do
  # Your routes here!
  namespace :api, defaults: { format: :json } do
    resources :parties, only: [:index, :show]
    resources :guests, only: [:index, :show] do
      resources :gifts, only: [:index]
    end
    resources :gifts, only: [:show]
  end
end
