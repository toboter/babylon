class CreateAuthorships < ActiveRecord::Migration
  def change
    create_table :authorships do |t|
      t.integer :person_id
      t.integer :reference_id
      t.integer :predicate_id
      t.integer :position

      t.timestamps
      t.userstamps
    end
  end
end
