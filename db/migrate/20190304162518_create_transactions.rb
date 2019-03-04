class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.datetime :date_time
      t.integer :price
      t.references :token, foreign_key: true
      t.references :buying_user
      t.references :selling_user

      t.timestamps
    end
  end
end
