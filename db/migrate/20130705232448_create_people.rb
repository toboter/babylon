class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.integer :user_id
      t.string :first_name
      t.string :last_name
      t.string :grade
      t.string :nickname
      t.datetime :date_of_birth
      t.datetime :date_of_death
      t.string :profession
      t.string :gender
      t.string :public_email
      t.string :slug

      t.timestamps
      t.userstamps
    end

    add_index :people, :slug, unique: true
  end
end
