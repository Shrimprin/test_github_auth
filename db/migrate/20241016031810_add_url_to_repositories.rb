class AddUrlToRepositories < ActiveRecord::Migration[7.2]
  def change
    add_column :repositories, :url, :string, null: false
  end
end
