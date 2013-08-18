class CreateTodolists < ActiveRecord::Migration
  def change
    create_table :todolists do |t|
      t.string :name
      t.belongs_to :project
      t.integer :responsible_id

      t.timestamps
      t.userstamps
    end
    add_index :todolists, :project_id
  end
end
