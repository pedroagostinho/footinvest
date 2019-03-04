class CreateMarketValues < ActiveRecord::Migration[5.2]
  def change
    create_table :market_values do |t|
      t.datetime :date_time
      t.integer :market_value
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
