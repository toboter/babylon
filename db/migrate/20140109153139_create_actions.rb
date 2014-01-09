class CreateActions < ActiveRecord::Migration
  def change
    create_table :actions do |t|
      t.references :person
      t.references :predicate
      t.date :actable_date
      t.string :actable_type
      t.integer :actable_id

      t.timestamps
      t.userstamps
    end
    add_index :actions, :person_id
    add_index :actions, :predicate_id
  end
end
