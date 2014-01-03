class CreateAffiliations < ActiveRecord::Migration
  def change
    create_table :affiliations do |t|
      t.references :person
      t.references :institution
      t.datetime :from
      t.datetime :to
      t.boolean :primary

      t.timestamps
      t.userstamps
    end
    add_index :affiliations, :person_id
    add_index :affiliations, :institution_id
  end
end
