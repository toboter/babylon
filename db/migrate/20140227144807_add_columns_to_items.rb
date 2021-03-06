class AddColumnsToItems < ActiveRecord::Migration
  def change
    add_column :items, :description, :text
    add_column :items, :slug, :string
    add_index :items, :slug, unique: true
  end
end
