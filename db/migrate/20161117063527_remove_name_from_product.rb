class RemoveNameFromProduct < ActiveRecord::Migration[5.0]
  def change
  	remove_column :products, :name
  end
end
