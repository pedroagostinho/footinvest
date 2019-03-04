class CreateNews < ActiveRecord::Migration[5.2]
  def change
    create_table :news do |t|
      t.datetime :date_time
      t.string :tag
      t.string :title
      t.string :summary
      t.text :content
      t.references :club, foreign_key: true
      t.references :player, foreign_key: true

      t.timestamps
    end
  end
end
