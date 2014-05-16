class AddPropertiesToItems < ActiveRecord::Migration
  def change
    add_column :items, :properties, :text
  end
end
