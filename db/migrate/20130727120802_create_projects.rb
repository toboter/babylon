class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.belongs_to :group

      t.timestamps
      t.userstamps
    end
    add_index :projects, :group_id
  end
end
