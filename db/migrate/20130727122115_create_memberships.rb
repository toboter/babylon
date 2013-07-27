class CreateMemberships < ActiveRecord::Migration
  def change
    create_table :memberships do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.string :role

      t.timestamps
      t.userstamps
    end
    add_index :memberships, :user_id
    add_index :memberships, :project_id
  end
end
