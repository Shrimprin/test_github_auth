class AddParentIdToFileItem < ActiveRecord::Migration[7.2]
  def change
    add_column :file_items, :parent_id, :integer
  end
end
