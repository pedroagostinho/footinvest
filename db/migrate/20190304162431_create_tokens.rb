class CreateTokens < ActiveRecord::Migration[5.2]
  def change
    create_table :tokens do |t|
      t.boolean :on_sale
      t.integer :last_price
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
