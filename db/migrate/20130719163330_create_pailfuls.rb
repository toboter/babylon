class CreatePailfuls < ActiveRecord::Migration
  def change
    create_table :pailfuls do |t|
      t.references :asset
      t.references :bucket

      t.timestamps
      t.userstamps
    end
    add_index :pailfuls, :asset_id
    add_index :pailfuls, :bucket_id
  end
end
