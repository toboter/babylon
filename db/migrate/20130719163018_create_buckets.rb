class CreateBuckets < ActiveRecord::Migration
  def change
    create_table :buckets do |t|
      t.string :attachable_type
      t.integer :attachable_id
      t.string :name
      t.integer :cover_asset_id
      t.boolean :name_fixed

      t.timestamps
      t.userstamps
    end
  end
end
