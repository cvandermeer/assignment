# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_12_29_220706) do
  create_table "abilities", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "slug"
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "abilities_base_pokemons", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "ability_id", null: false
    t.bigint "base_pokemon_id", null: false
    t.index ["ability_id", "base_pokemon_id"], name: "index_abilities_base_pokemons_on_ability_id_and_base_pokemon_id"
    t.index ["base_pokemon_id", "ability_id"], name: "index_abilities_base_pokemons_on_base_pokemon_id_and_ability_id"
  end

  create_table "base_pokemons", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.integer "dex_index"
    t.string "name"
    t.string "slug"
    t.string "description"
    t.text "pokemon_types"
    t.string "sprite"
    t.integer "base_catch_rate"
    t.string "levelling_rate"
    t.string "evolves_from"
    t.integer "evolution_level"
    t.float "height"
    t.float "weight"
    t.integer "hp"
    t.integer "attack"
    t.integer "special_attack"
    t.integer "defense"
    t.integer "special_defense"
    t.integer "speed"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "base_pokemons_moves", id: false, charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "move_id", null: false
    t.bigint "base_pokemon_id", null: false
    t.index ["base_pokemon_id", "move_id"], name: "index_base_pokemons_moves_on_base_pokemon_id_and_move_id"
    t.index ["move_id", "base_pokemon_id"], name: "index_base_pokemons_moves_on_move_id_and_base_pokemon_id"
  end

  create_table "battles", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "trainer_id", null: false
    t.string "battle_type"
    t.integer "opponent_id", null: false
    t.string "state", default: "start"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["trainer_id"], name: "index_battles_on_trainer_id"
  end

  create_table "moves", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.string "slug"
    t.string "description"
    t.string "pokemon_type"
    t.integer "accuracy"
    t.integer "base_power"
    t.integer "pp"
    t.integer "max_move_power"
    t.integer "z_move_power"
    t.integer "generation"
    t.integer "level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pokemons", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.bigint "base_pokemon_id", null: false
    t.bigint "trainer_id"
    t.integer "hp"
    t.integer "attack"
    t.integer "special_attack"
    t.integer "defense"
    t.integer "special_defense"
    t.integer "speed"
    t.integer "current_hp"
    t.integer "current_attack"
    t.integer "current_special_attack"
    t.integer "current_defense"
    t.integer "current_special_defense"
    t.integer "current_speed"
    t.integer "level"
    t.integer "current_experience"
    t.integer "experience_to_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["base_pokemon_id"], name: "index_pokemons_on_base_pokemon_id"
    t.index ["trainer_id"], name: "index_pokemons_on_trainer_id"
  end

  create_table "trainers", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "type_matchups", charset: "utf8mb4", collation: "utf8mb4_0900_ai_ci", force: :cascade do |t|
    t.string "primary_type"
    t.string "secondary_type"
    t.text "strong_against"
    t.text "weak_against"
    t.text "effectless_against"
    t.text "resistant_to"
    t.text "vulnerable_to"
    t.text "effectless_to"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["primary_type"], name: "index_type_matchups_on_primary_type"
    t.index ["secondary_type"], name: "index_type_matchups_on_secondary_type"
  end

  add_foreign_key "battles", "trainers"
  add_foreign_key "pokemons", "base_pokemons"
  add_foreign_key "pokemons", "trainers"
end
