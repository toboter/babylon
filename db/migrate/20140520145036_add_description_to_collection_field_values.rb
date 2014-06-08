class AddDescriptionToCollectionFieldValues < ActiveRecord::Migration
  def change
    add_column :collection_field_values, :description, :text
  end
end
