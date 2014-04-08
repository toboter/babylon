class RemoveNamesFromPeople < ActiveRecord::Migration
  def change
  	remove_column :people, :first_name
  	remove_column :people, :last_name
  end
end
