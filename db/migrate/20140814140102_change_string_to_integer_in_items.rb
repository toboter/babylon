class ChangeStringToIntegerInItems < ActiveRecord::Migration
  def change
  	change_column :items, :inventory_number, 'integer USING CAST(inventory_number AS integer)'
  	change_column :items, :mds_id, 'integer USING CAST(mds_id AS integer)'
  	change_column :items, :dissov_id, 'integer USING CAST(dissov_id AS integer)'
  	change_column :items, :excavation_id, 'integer USING CAST(excavation_id AS integer)'
  	add_column :items, :excavation_prefix, :string
  end
end
