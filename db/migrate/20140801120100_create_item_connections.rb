class CreateItemConnections < ActiveRecord::Migration
  def change
    create_table :item_connections do |t|
      t.belongs_to :item
      t.integer :inverse_item_id
      t.belongs_to :predicate

      t.timestamps
      t.userstamps
    end
    add_index :item_connections, :item_id
    add_index :item_connections, :inverse_item_id
    add_index :item_connections, :predicate_id
  end
end
