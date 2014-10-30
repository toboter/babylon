class AddSimpleAttributesToItems < ActiveRecord::Migration
  def change
  	add_column :items, :dimensions, :string
  	add_column :items, :condition, :string
  	add_column :items, :material, :string
  	add_column :items, :technique, :string
  	add_column :items, :place, :string
  	add_column :items, :period, :string
  	add_column :items, :excavation_date, :string
  	add_column :items, :excavation_place, :string
  	add_column :items, :excavation_situation, :text
  	remove_column :items, :properties

  	remove_index :collection_field_values, :collection_field_id
  	remove_index :collection_fields, :collection_id
  	drop_table :collection_fields
  	drop_table :collection_field_values
  end
end
