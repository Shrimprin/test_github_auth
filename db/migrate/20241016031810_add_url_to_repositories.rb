class AddUrlToRepositories < ActiveRecord::Migration[7.2]
  def change
    add_column :repositories, :path, :string, null: false
  end
end
