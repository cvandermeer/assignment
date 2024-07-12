require 'rails_helper'

RSpec.describe Trainer, type: :model do
  fixtures :trainers, :base_pokemons

  describe '.active_pokemon' do
    let(:trainer) { trainers(:ash) }
    let!(:dead_pokemon) { trainer.pokemons.create(base_pokemon: base_pokemons(:pidgey), hp: 40, current_hp: 0) }
    let!(:alive_pokemon) { trainer.pokemons.create(base_pokemon: base_pokemons(:pidgey), hp: 30, current_hp: 20) }

    it 'returns the first alive pokemon' do
      expect(trainer.active_pokemon).to eq(alive_pokemon)
    end
  end
end
