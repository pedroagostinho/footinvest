class CreatePortfolios < ActiveRecord::Migration[5.2]
  def change
    create_table :portfolios do |t|
      t.integer :value
      t.references :user, foreign_key: true
      t.datetime :date_time

      t.timestamps
    end
  end
end
