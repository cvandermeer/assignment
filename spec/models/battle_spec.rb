require 'rails_helper'

RSpec.describe Battle, type: :model do
  fixtures :battles

  describe '.escape' do
    let(:battle) { battles(:started) }

    it 'escapes the battle' do
      allow(battle).to receive(:escape_attempt_successful).and_return(true)

      expect { battle.escape }
        .to change(battle, :state)
        .from(Battle::STATE_START.to_s).to(Battle::STATE_ESCAPED.to_s)
    end
  end
end
