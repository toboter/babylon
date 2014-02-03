class RenamePersonToPersonNames < ActiveRecord::Migration
  def change
  	rename_column :editorships, :person_id, :person_name_id
  	rename_column :authorships, :person_id, :person_name_id
  end

end
