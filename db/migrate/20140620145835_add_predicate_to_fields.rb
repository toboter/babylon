class AddPredicateToFields < ActiveRecord::Migration
  def change
  	add_column :collection_fields, :predicate_id, :integer
  	add_column :project_study_fields, :predicate_id, :integer
  end
end
