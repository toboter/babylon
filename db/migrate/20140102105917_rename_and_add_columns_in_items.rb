class RenameAndAddColumnsInItems < ActiveRecord::Migration
  def change
  	rename_column :items, :accession_number, :inventory_number
  	rename_column :items, :accession_number_index, :inventory_number_index

  	add_column :items, :classification_id, :integer
  end

end
