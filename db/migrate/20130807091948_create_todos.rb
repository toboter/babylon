class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :name
      t.date :due_to
      t.belongs_to :project
      t.integer :assigned_id
      t.boolean :completed
      t.date :starts_at
      t.integer :depends_on

      t.timestamps
      t.userstamps
    end
    add_index :todos, :project_id
  end
end
