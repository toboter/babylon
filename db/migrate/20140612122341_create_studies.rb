class CreateStudies < ActiveRecord::Migration
  def change
    create_table :studies do |t|
      t.belongs_to :list
      t.text :properties
      t.string :studyable_type
      t.integer :studyable_id

      t.timestamps
      t.userstamps
    end
    add_index :studies, :list_id
  end
end
