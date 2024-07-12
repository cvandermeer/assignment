require 'rails_helper'

RSpec.describe Battle, type: :model do
  fixtures :battles

  describe '.escape' do
    let(:battle) { battles(:started) }

    it 'escapes the battle' do
      allow(battle).to receive(:escape_chance_success?).and_return(true)

      expect { battle.escape! }
        .to change(battle, :state)
        .from(Battle::STATE_START.to_s).to(Battle::STATE_ESCAPED.to_s)
    end

    it 'raises an error if the escape attempt fails' do
      allow(battle).to receive(:escape_chance_success?).and_return(false)

      expect { battle.escape! }
        .not_to change(battle, :state)
    end
  end

  describe '.capture' do
    let(:battle) { battles(:started) }

    it 'captures the opponent' do
      allow(battle).to receive(:capture_attempt_successful?).and_return(true)

      expect { battle.capture! }
        .to change(battle, :state)
        .from(Battle::STATE_START.to_s).to(Battle::STATE_CAPTURED.to_s)
    end

    context 'on a failed capture' do
      before do
        allow(battle).to receive(:capture_attempt_successful?).and_return(false)
      end

      context 'when pokemon flees' do
        before do
          allow(battle).to receive(:pokemon_flees?).and_return(true)
        end

        it 'attempts to escape' do
          expect { battle.capture! }
            .to change(battle, :state)
            .from(Battle::STATE_START.to_s).to(Battle::STATE_ESCAPED.to_s)
        end
      end

      context 'when pokemon does not flee' do
        before do
          allow(battle).to receive(:pokemon_flees?).and_return(false)
        end

        it 'does not attempt to escape' do
          expect { battle.capture! }
            .not_to change(battle, :state)
        end
      end
    end
  end
end
