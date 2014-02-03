class CreatePersonNames < ActiveRecord::Migration
  def change
    create_table :person_names do |t|
      t.integer :person_id
      t.string :first_name
      t.string :last_name
      t.boolean :primary

      t.timestamps
      t.userstamps
    end
    
  end
end
