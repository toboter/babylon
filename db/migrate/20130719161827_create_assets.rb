class CreateAssets < ActiveRecord::Migration
  def change
    create_table :assets do |t|
      t.string :assetfile
      t.string :name
      t.integer :parent_id
      t.string :content_type
      t.string :file_size
      t.string :file_name
      t.integer :file_author
      t.datetime :file_datetime

      t.timestamps
      t.userstamps
    end
  end
end
