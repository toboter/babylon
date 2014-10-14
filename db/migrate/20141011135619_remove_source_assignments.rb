class RemoveSourceAssignments < ActiveRecord::Migration
  def up
  	add_column :actions, :target, :string
  	add_column :actions, :source_id, :integer
  	remove_column :actions, :person_id
  	remove_column :actions, :actable_date_text
  	drop_table :source_assignments
  end

  def down
  	remove_column :actions, :target
  	add_column :actions, :person_id, :integer
  	add_column :actions, :actable_date_text, :string
    create_table :source_assignments do |t|
      t.integer :source_id
      t.string :target
      t.integer :action_id

      t.timestamps
      t.userstamps
    end

  end
end
