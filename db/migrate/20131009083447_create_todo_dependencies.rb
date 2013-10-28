class CreateTodoDependencies < ActiveRecord::Migration
  def change
    create_table :todo_dependencies do |t|
      t.references :todo
      t.integer :depends_on_id

      t.timestamps
      t.userstamps
    end
    add_index :todo_dependencies, :todo_id
  end
end
