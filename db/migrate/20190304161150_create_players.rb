class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :photo
      t.integer :age
      t.integer :height
      t.string :nationality
      t.string :position
      t.string :social_url
      t.references :club, foreign_key: true

      t.timestamps
    end
  end
end
