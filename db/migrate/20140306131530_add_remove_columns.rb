class AddRemoveColumns < ActiveRecord::Migration
  def change
    remove_column :references, :babylon_specific
    add_column :references, :created_by_project_id, :integer
    add_column :groups, :description, :text
  end
end
