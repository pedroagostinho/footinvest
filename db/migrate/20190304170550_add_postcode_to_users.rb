class AddPostcodeToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :postcode, :string
  end
end
