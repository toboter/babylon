class AddFieldsToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :speaker_id, :integer
    add_column :groups, :group_admin_id, :integer
  end
end
