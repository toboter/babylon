class CreateReferences < ActiveRecord::Migration
  def change
    create_table :references do |t|
      t.string :title
      t.datetime :original_date
      t.string :ancestry
      t.integer :publisher
      t.integer :place
      t.integer :reference_type_id
      t.string :signatory
      t.string :book_identifier #ISBN, ISSN
      t.string :alternative_author
      t.string :slug

      t.timestamps
      t.userstamps
    end
    add_index :references, :ancestry
    add_index :references, :slug, unique: true

  end
end
