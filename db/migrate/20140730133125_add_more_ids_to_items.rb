class AddMoreIdsToItems < ActiveRecord::Migration
  def change
  	add_column :items, :excavation_id, :string
  	add_column :items, :dissov_id, :string
  	add_column :items, :mds_id, :string
  end
end
