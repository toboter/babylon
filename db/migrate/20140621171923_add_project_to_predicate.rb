class AddProjectToPredicate < ActiveRecord::Migration
  def change
  	add_column :predicates, :project_id, :integer
  end
end
