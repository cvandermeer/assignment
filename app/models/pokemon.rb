class Pokemon < ApplicationRecord
  belongs_to :base_pokemon
  belongs_to :trainer, optional: true

  has_and_belongs_to_many :moves

  delegate :base_catch_rate,
           :dex_index,
           :levelling_rate,
           :evolves_from,
           :evolution_level,
           :name,
           :slug,
           :description,
           :pokemon_types,
           :sprite, to: :base_pokemon
end
