class Battle < ApplicationRecord
  include AASM

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
      transitions from: :start, to: :escaped, if: :escape_attempt_successful?
    end
  end

  private

  def escape_attempt_successful?
    rand(2) == 1
  end
end
