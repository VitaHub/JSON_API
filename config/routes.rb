Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :posts, only: :index
      resources :marks, only: :create
      resources :addresses, only: :index
    end
  end
end
