Rails.application.routes.draw do
  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :base_pokemons, only: :index
  resources :battles, only: [:new, :create, :show] do
    member do
      put :attack
      put :capture
      put :escape
    end
  end
  resources :encounters, only: :new
  resources :pokemons, only: :index
  resources :trainers, only: [] do
    put :heal_all_pokemon, on: :member
  end
end
