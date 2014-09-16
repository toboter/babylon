class SourceHierarchies < ActiveRecord::Migration
  def up
    create_table :source_hierarchies, :id => false do |t|
      t.integer  :ancestor_id, :null => false   # ID of the parent/grandparent/great-grandparent/... tag
      t.integer  :descendant_id, :null => false # ID of the target tag
      t.integer  :generations, :null => false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    add_index :source_hierarchies, [:ancestor_id, :descendant_id, :generations],
      :unique => true, :name => "source_anc_desc_udx"

    # For "all ancestors of…" selects,
    add_index :source_hierarchies, [:descendant_id],
      :name => "source_desc_idx"
  end

  def down
  	remove_index :source_hierarchies, [:ancestor_id, :descendant_id, :generations]
  	drop_table :source_hierarchies
  end
end
