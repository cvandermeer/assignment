class Battle < ApplicationRecord
  include AASM

  class EscapeAttemptFailed < StandardError; end

  belongs_to :trainer
  has_many :battle_logs

  has_one :opponent, class_name: "Pokemon", foreign_key: "id", primary_key: "opponent_id"

  enum battle_type: {
    pve: "pve",
    pvp: "pvp"
  }

  aasm(:battle, column: :state) do
    state :start, initial: true
    state :move_selection
    state :escaped
    state :captured
    state :victory
    state :defeat

    event :trainer_wins do
      transitions from: :start, to: :victory
    end

    event :trainer_loses do
      transitions from: :start, to: :defeat
    end

    event :escape do 
      transitions from: :start, to: :escaped, if: :escape_chance_success?      
      transitions from: :start, to: :start
    end
    
    event :capture do
      transitions from: :start, to: :captured, if: :capture_attempt_successful?, after: :add_pokemon_to_trainer
      transitions from: :start, to: :escaped, if: :pokemon_flees?
      transitions from: :start, to: :start
    end
  end

  def attack!
    trainer_active_pokemon = trainer.active_pokemon
    trainer_damage = trainer_active_pokemon.current_attack
    opponent.current_hp -= trainer_damage
    opponent.save!
    battle_logs.create!(content: "#{trainer_active_pokemon.name} attacks #{opponent.name} for #{trainer_damage} damage")

    if opponent.current_hp <= 0 
      return trainer_wins!
    end

    opponent_damage = opponent.current_attack

    trainer_active_pokemon.current_hp -= opponent_damage
    trainer_active_pokemon.save!
    battle_logs.create!(content: " #{opponent.name} attacks #trainer_active_pokemon.name} for #{opponent_damage} damage")
    
    if trainer.active_pokemon.nil?
      trainer_loses!
    end
  end

  private

  def capture_attempt_successful?
    rand(2) == 1
  end

  def handle_capture_failure
    escape! if pokemon_flees?
  end

  def pokemon_flees?
    rand(10) < 3
  end
  
  def escape_chance_success?
    rand(2) == 1
  end

  def add_pokemon_to_trainer
    trainer.pokemons << opponent
  end
end
