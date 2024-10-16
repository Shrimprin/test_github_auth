class ModifyUsersTable < ActiveRecord::Migration[7.2]
  def change
    remove_column :users, :email, :string
    add_column :users, :name, :string, null: false
    add_column :users, :access_token, :string, null: false
  end
end
