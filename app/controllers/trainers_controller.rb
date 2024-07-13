class TrainersController < ApplicationController
  def heal_all_pokemon
    current_trainer.pokemons.each do |pokemon|
      pokemon.current_hp = pokemon.hp
      pokemon.save
    end

    redirect_to root_path
  end
end