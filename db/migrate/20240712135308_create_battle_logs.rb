class CreateBattleLogs < ActiveRecord::Migration[7.0]
  def change
    create_table :battle_logs do |t|
      t.string :content
      t.references :battle, null: false, foreign_key: true

      t.timestamps
    end
  end
end
