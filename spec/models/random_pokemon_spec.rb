require 'rails_helper'

RSpec.describe RandomPokemon, type: :model do
  fixtures :base_pokemons, :trainers, :pokemons

  describe '.retrieve' do
    let(:ash) { trainers(:ash) }
    
    it 'returns a random pokemon' do
      expect(RandomPokemon.retrieve).to be_a(Pokemon)
    end

    it "returns a random pokemon close in level to the trainer's strongest pokemon" do
      expect(RandomPokemon.retrieve(ash).level)
        .to be_within(3).of(ash.pokemons.maximum(:level))
    end
  end
end
