class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.string :status
      t.integer :last_price
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
