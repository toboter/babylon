class AddJoinsToIdToItems < ActiveRecord::Migration
  def up
  	add_column :items, :joins_to_id, :integer
    create_table :item_hierarchies, :id => false do |t|
      t.integer  :ancestor_id, :null => false   # ID of the parent/grandparent/great-grandparent/... tag
      t.integer  :descendant_id, :null => false # ID of the target tag
      t.integer  :generations, :null => false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    add_index :item_hierarchies, [:ancestor_id, :descendant_id, :generations],
      :unique => true, :name => "item_anc_desc_udx"

    # For "all ancestors of…" selects,
    add_index :item_hierarchies, [:descendant_id],
      :name => "item_desc_idx"
  end

  def down
  	remove_index :item_hierarchies, [:ancestor_id, :descendant_id, :generations]
  	drop_table :item_hierarchies
  	remove_column :items, :joins_to_id
  end
end