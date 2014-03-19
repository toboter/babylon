class CreateIssues < ActiveRecord::Migration
  def change
    create_table :issues do |t|
      t.string :name
      t.integer :issuable_id
      t.string :issuable_type
      t.boolean :closed
      t.integer :assigned_id

      t.timestamps
      t.userstamps
    end
    drop_table :comments
  end
end
