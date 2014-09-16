class CreateSourceAssignments < ActiveRecord::Migration
  def change
    create_table :source_assignments do |t|
      t.integer :source_id
      t.string :target
      t.integer :action_id

      t.timestamps
      t.userstamps
    end
  end
end
