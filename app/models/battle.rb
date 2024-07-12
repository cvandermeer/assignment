class Battle < ApplicationRecord
  include AASM

  class EscapeAttemptFailed < StandardError; end

  belongs_to :trainer

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

    event :escape do 
      transitions from: :start, to: :escaped, if: :escape_chance_success?      
      transitions from: :start, to: :start
    end
    
    event :capture do
      transitions from: :start, to: :captured, if: :capture_attempt_successful?
      transitions from: :start, to: :escaped, if: :pokemon_flees?
      transitions from: :start, to: :start
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
end
