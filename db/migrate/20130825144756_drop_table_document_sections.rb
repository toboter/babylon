class DropTableDocumentSections < ActiveRecord::Migration
  def up
  	remove_index :document_sections, :document_id
  	drop_table :document_sections
  	rename_column :documents, :abstract, :content
  end

  def down
    create_table :document_sections do |t|
      t.string :title
      t.text :content
      t.belongs_to :document

      t.timestamps
      t.userstamps
    end
    add_index :document_sections, :document_id
    rename_column :documents, :content, :abstract
  end
end
