class CreateStats < ActiveRecord::Migration[5.2]
  def change
    create_table :stats do |t|
      t.integer :games
      t.integer :goals
      t.integer :assists
      t.integer :minutes_played
      t.string :form
      t.references :player, foreign_key: true
      t.references :competition, foreign_key: true
      t.integer :yellow_card
      t.integer :red_card

      t.timestamps
    end
  end
end
