class ChangeStatusNameInTokens < ActiveRecord::Migration[5.2]
  def change
    rename_column :tokens, :status, :on_sale?
  end
end
