class AddBabylonSpecificColumnToReferences < ActiveRecord::Migration
  def change
  	add_column :references, :babylon_specific, :boolean
  end
end
