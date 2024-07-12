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
        hp: stat_value(sample_base_pokemon.hp, level),
        attack: stat_value(sample_base_pokemon.attack, level),
        special_attack: stat_value(sample_base_pokemon.special_attack, level),
        defense: stat_value(sample_base_pokemon.defense, level),
        special_defense: stat_value(sample_base_pokemon.special_defense, level),
        speed: stat_value(sample_base_pokemon.speed, level),
        current_hp: stat_value(sample_base_pokemon.hp, level),
        current_attack: stat_value(sample_base_pokemon.attack, level),
        current_special_attack: stat_value(sample_base_pokemon.special_attack, level),
        current_defense: stat_value(sample_base_pokemon.defense, level),
        current_special_defense: stat_value(sample_base_pokemon.special_defense, level),
        current_speed: stat_value(sample_base_pokemon.speed, level),
        current_experience: 0,
        experience_to_level: 0
      )
    end

    private

    def stat_value(base_stat, level)
      return 1 unless base_stat

      base_stat + (base_stat / 50) * level
    end
  end
end