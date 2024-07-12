class RandomPokemon
  class << self
    def retrieve(trainer = nil)
      sample_base_pokemon = BasePokemon.all.sample

      return if sample_base_pokemon.nil?

      strongest_pokemon_level = trainer.pokemons.maximum(:level) if trainer
      level = strongest_pokemon_level ? strongest_pokemon_level + rand(-3..3) : 1
      level = [level, 1].max

      sample_base_pokemon.pokemons.create(
        trainer: nil,
        level: level,
        hp: 1,
        attack: 1,
        special_attack: 1,
        defense: 1,
        special_defense: 1,
        speed: 1,
        current_hp: 1,
        current_attack: 1,
        current_special_attack: 1,
        current_defense: 1,
        current_special_defense: 1,
        current_speed: 1,
        current_experience: 0,
        experience_to_level: 0
      )
    end
  end
end