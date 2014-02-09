class CreateSnippets < ActiveRecord::Migration
  def change
    create_table :snippets do |t|
      t.string :name
      t.text :description
      t.string :snippet_type
      t.boolean :pinned

      t.timestamps
      t.userstamps
    end
  end
end
