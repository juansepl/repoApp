Rails.application.routes.draw do
  resources :repositories do
    member do
      patch 'update_from_api'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "repositories#index"
end
