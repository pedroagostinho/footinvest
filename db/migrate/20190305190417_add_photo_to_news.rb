class AddPhotoToNews < ActiveRecord::Migration[5.2]
  def change
    add_column :news, :photo, :string
  end
end
