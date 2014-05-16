class CreateCollectionFieldValues < ActiveRecord::Migration
  def change
    create_table :collection_field_values do |t|
      t.string :field_value
      t.belongs_to :collection_field

      t.timestamps
      t.userstamps
    end
    add_index :collection_field_values, :collection_field_id
  end
end
