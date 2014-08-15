class ChangePropertiesColumnsToHstore < ActiveRecord::Migration
  def up
    remove_column :items, :properties
    remove_column :studies, :properties

  	add_column :items, :properties, :hstore
  	add_column :studies, :properties, :hstore

    add_hstore_index :items, :properties
    add_hstore_index :studies, :properties
  	# execute "CREATE INDEX items_properties ON items USING GIN(properties)"
  	# execute "CREATE INDEX studies_properties ON studies USING GIN(properties)"
  end

  def down
    remove_hstore_index :items, :properties
    remove_hstore_index :studies, :properties
  	#execute "DROP INDEX items_properties"
  	#execute "DROP INDEX studies_properties"

  	remove_column :items, :properties
  	remove_column :studies, :properties

    add_column :items, :properties, :text
    add_column :studies, :properties, :text
  end
end
