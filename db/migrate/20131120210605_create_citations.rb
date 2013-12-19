class CreateCitations < ActiveRecord::Migration
  def change
    create_table :citations do |t|
      t.references :reference
      t.string :ref_target
      t.references :citable, polymorphic: true
      t.integer :predicate_id

      t.timestamps
      t.userstamps
    end
    add_index :citations, :reference_id
  end
end
