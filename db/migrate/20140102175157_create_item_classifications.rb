class CreateItemClassifications < ActiveRecord::Migration
  def up
    create_table :item_classifications do |t|
      t.string :name
      t.text :description
      t.integer :parent_id

      t.timestamps
      t.userstamps
    end
    create_table :item_classification_hierarchies, :id => false do |t|
      t.integer  :ancestor_id, :null => false   # ID of the parent/grandparent/great-grandparent/... tag
      t.integer  :descendant_id, :null => false # ID of the target tag
      t.integer  :generations, :null => false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    add_index :item_classification_hierarchies, [:ancestor_id, :descendant_id, :generations],
      :unique => true, :name => "item_classification_anc_desc_udx"

    # For "all ancestors of…" selects,
    add_index :item_classification_hierarchies, [:descendant_id],
      :name => "item_classification_desc_idx"
  end

  def down
  	remove_index :item_classification_hierarchies, [:ancestor_id, :descendant_id, :generations]
  	drop_table :item_classification_hierarchies
  	drop_table :item_classifications
  end
end
