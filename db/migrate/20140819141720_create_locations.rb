class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.belongs_to :locatable
      t.string :locatable_type
      t.belongs_to :predicate

      t.timestamps
      t.userstamps
    end
    add_index :locations, [:locatable_id, :locatable_type]
    add_index :locations, :predicate_id
  end
end
