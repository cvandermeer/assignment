Rails.application.routes.draw do
  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :base_pokemons, only: :index
  resources :pokemons, only: :index
  resources :encounters, only: :new
  resources :battles, only: [:new, :create, :show] do
    member do
      put :escape
      put :capture
    end
  end
end
