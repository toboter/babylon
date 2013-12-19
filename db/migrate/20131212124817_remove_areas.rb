class RemoveAreas < ActiveRecord::Migration
  def up
  	drop_table :areas
  	rename_column :groups, :area_id, :cluster_id
  end

  def down
    create_table :areas do |t|
      t.string :name

      t.timestamps
      t.userstamps
    end
    rename_column :groups, :cluster_id, :area_id
  end
end
