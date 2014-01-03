class RemoveInstitutionIdFromPeople < ActiveRecord::Migration
  def up
  	remove_column :people, :institution_id
  end

  def down
  	add_column :people, :institution_id, :integer
  end
end
