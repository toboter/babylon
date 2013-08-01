class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :title
      t.string :documentable_type
      t.integer :documentable_id
      t.string :document_type
      t.text :abstract

      t.timestamps
      t.userstamps
    end
    add_index :documents, [:documentable_id, :documentable_type]
  end
end
