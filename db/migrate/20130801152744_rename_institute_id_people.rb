class RenameInstituteIdPeople < ActiveRecord::Migration
  def up
  	rename_column :people, :institute_id, :institution_id
  	add_column :people, :show_inst_address, :boolean
  end

  def down
  	rename_column :people, :institution_id, :institute_id
  	remove_column :people, :show_inst_address
  end
end
