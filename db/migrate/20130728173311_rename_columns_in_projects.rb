class RenameColumnsInProjects < ActiveRecord::Migration
  def up
  	remove_column :projects, :group_id
  	add_column :projects, :projectable_id, :integer
  	add_column :projects, :projectable_type, :string
  end

  def down
  	add_column :projects, :group_id, :integer
  	remove_column :projects, :projectable_id
  	remove_column :projects, :projectable_type
  end
end
