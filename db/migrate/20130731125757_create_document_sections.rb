class CreateDocumentSections < ActiveRecord::Migration
  def change
    create_table :document_sections do |t|
      t.string :title
      t.text :content
      t.belongs_to :document

      t.timestamps
      t.userstamps
    end
    add_index :document_sections, :document_id
  end
end
