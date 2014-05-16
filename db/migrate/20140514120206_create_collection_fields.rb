class CreateCollectionFields < ActiveRecord::Migration
  def change
    create_table :collection_fields do |t|
      t.string :field_type
      t.boolean :required
      t.belongs_to :collection
      t.string :name

      t.timestamps
      t.userstamps
    end
    add_index :collection_fields, :collection_id
  end
end
