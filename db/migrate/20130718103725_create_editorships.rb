class CreateEditorships < ActiveRecord::Migration
  def change
    create_table :editorships do |t|
      t.belongs_to :book
      t.belongs_to :person

      t.timestamps
      t.userstamps
    end
    add_index :editorships, :book_id
    add_index :editorships, :person_id
  end
end
