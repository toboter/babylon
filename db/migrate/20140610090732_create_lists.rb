class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :name
      t.boolean :forkable
      t.integer :forked_from_id
      t.boolean :featured
      t.text :description
      t.belongs_to :project

      t.timestamps
      t.userstamps
    end
    add_index :lists, :project_id
  end
end
