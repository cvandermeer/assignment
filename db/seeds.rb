# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

trainer = Trainer.where(name: "Ash Ketchum").first_or_create
pikachu = BasePokemon.find_by(name: "Pikachu")

trainer.pokemons.where(
  base_pokemon: pikachu,
  level: 1,
  hp: 200,
  attack: 55,
  special_attack: 50,
  defense: 40,
  special_defense: 50,
  speed: 90,
  current_hp: 200,
  current_attack: 55,
  current_special_attack: 50,
  current_defense: 40,
  current_special_defense: 50,
  current_speed: 90,
  current_experience: 0,
  experience_to_level: 0
).first_or_create
