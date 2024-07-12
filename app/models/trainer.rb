class Trainer < ApplicationRecord
  has_many :pokemons

  def active_pokemon
    pokemons.alive.first
  end
end
