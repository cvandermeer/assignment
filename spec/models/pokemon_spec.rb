require 'rails_helper'

RSpec.describe Pokemon, type: :model do
  fixtures :base_pokemons

  describe '.hp_percentage' do  
    let(:pokemon) { Pokemon.create(base_pokemon: base_pokemons(:pidgey), hp: 40, current_hp: 20) }

    it 'returns a percentage based on health and current hp' do
      expect(pokemon.hp_percentage)
        .to eq(50.to_f)
    end
  end

  describe 'alive' do
    before do
      Pokemon.delete_all
      Pokemon.create(base_pokemon: base_pokemons(:pidgey), current_hp: 20) 
      Pokemon.create(base_pokemon: base_pokemons(:pidgey), current_hp: 0) 
    end

    it 'returns all alive pokemon' do
      expect(Pokemon.alive.count).to eq(1)
    end
  end

  describe '.attack!' do
    let(:pokemon) { Pokemon.create(base_pokemon: base_pokemons(:pidgey), current_hp: 40, current_attack: 20) }
    let(:opponent) { Pokemon.create(base_pokemon: base_pokemons(:pidgey), current_hp: 40, current_attack: 20) }

    it 'deals damage to the opponent' do
      expect { pokemon.attack!(opponent) }
        .to change(opponent, :current_hp)
        .by(-pokemon.current_attack)
    end
  end
end

