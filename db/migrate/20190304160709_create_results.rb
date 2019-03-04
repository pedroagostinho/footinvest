class CreateResults < ActiveRecord::Migration[5.2]
  def change
    create_table :results do |t|
      t.datetime :date_time
      t.references :competition, foreign_key: true
      t.integer :home_club_goals
      t.integer :away_club_goals
      t.references :home_club
      t.references :away_club

      t.timestamps
    end
  end
end
