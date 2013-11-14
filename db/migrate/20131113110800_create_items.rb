class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.references :collection
      t.string :accession_number
      t.string :accession_number_index
      t.datetime :accession_date
      t.integer :context_id
      # Es erscheint sinnvoller die Items mit der entsprechenden Classification zu taggen
      # t.integer :classification_id
      t.string :title

      t.timestamps
      t.userstamps
    end
    add_index :items, :collection_id
  end
end
