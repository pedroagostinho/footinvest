class AddOwnerToToken < ActiveRecord::Migration[5.2]
  def change
    add_column :tokens, :owner, :integer
  end
end
