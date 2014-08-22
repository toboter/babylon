class AddCommentToReferences < ActiveRecord::Migration
  def change
    add_column :references, :comment, :text
    remove_column :references, :created_by_project_id
  end
end
