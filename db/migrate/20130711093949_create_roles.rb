class CreateRoles < ActiveRecord::Migration
  def change
    create_table :roles do |t|
      t.integer :user_id
      t.string :role

      t.timestamps
      t.userstamps
    end
  end
end
