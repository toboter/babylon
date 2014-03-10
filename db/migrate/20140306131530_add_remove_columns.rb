class AddRemoveColumns < ActiveRecord::Migration
  def up
    remove_column :references, :babylon_specific
    add_column :references, :created_by_project_id, :integer
  end

  def down
  end
end
