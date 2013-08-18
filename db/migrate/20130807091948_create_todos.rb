class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :name
      t.datetime :due_to
      t.belongs_to :todolist
      t.integer :assigned_id
      t.boolean :completed

      t.timestamps
      t.userstamps
    end
    add_index :todos, :todolist_id
  end
end
