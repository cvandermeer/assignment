class EncountersController < ApplicationController
  def new
    @wild_pokemon = RandomPokemon.retrieve(current_trainer)
  end
end
