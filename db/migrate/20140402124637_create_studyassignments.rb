class CreateStudyassignments < ActiveRecord::Migration
  def change
    create_table :studyassignments do |t|
      t.integer :item_id
      t.integer :project_id

      t.timestamps
      t.userstamps
    end
  end
end
