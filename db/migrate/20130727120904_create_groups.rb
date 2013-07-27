class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.belongs_to :area

      t.timestamps
      t.userstamps
    end
    add_index :groups, :area_id
  end
end
