class TagHierarchies < ActiveRecord::Migration
  def up
    add_column :tags, :parent_id, :integer
    create_table :tag_hierarchies, :id => false do |t|
      t.integer  :ancestor_id, :null => false   # ID of the parent/grandparent/great-grandparent/... tag
      t.integer  :descendant_id, :null => false # ID of the target tag
      t.integer  :generations, :null => false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    add_index :tag_hierarchies, [:ancestor_id, :descendant_id, :generations],
      :unique => true, :name => "tag_anc_desc_udx"

    # For "all ancestors of…" selects,
    add_index :tag_hierarchies, [:descendant_id],
      :name => "tag_desc_idx"
  end

  def down
  	remove_index :tag_hierarchies, [:ancestor_id, :descendant_id, :generations]
  	drop_table :tag_hierarchies
  	remove_column :tags, :parent_id
  end
end
