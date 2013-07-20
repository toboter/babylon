class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.string :volume
      t.string :place
      t.string :publisher
      t.string :year
      t.string :book_type
      t.boolean :unpublished
      t.integer :serial_id
      t.string :book_identifier
      t.string :uri

      t.timestamps
      t.userstamps
    end
  end
end
