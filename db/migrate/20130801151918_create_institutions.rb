class CreateInstitutions < ActiveRecord::Migration
  def change
    create_table :institutions do |t|
      t.string :name
      t.string :phone
      t.string :fax
      t.string :uri
      t.string :street
      t.string :zip
      t.string :city
      t.string :country
      t.integer :parent_id
      t.integer :creator_id
      t.integer :updater_id

      t.timestamps
    end
  end
end
