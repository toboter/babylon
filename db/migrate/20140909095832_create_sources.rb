class CreateSources < ActiveRecord::Migration
  def change
    create_table :sources do |t|
      t.integer :author_id
      t.string :source_type
      t.date :original_date
      t.string :format
      t.integer :institution_id
      t.text :comment
      t.integer :parent_id
      t.string :condition

      t.timestamps
      t.userstamps
    end
  end
end
