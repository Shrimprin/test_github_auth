class FileItems < ActiveRecord::Migration[7.2]
  def change
    create_table :file_items do |t|
      t.references :repository, null: false, foreign_key: true
      t.string :name, null: false
      t.integer :type, null: false
      t.text :content

      t.timestamps
    end
  end
end
