class CreateCollections < ActiveRecord::Migration
  def change
    create_table :collections do |t|
      t.references :institution
      t.string :name
      t.string :shortcut

      t.timestamps
      t.userstamps
    end
    add_index :collections, :institution_id
  end
end
