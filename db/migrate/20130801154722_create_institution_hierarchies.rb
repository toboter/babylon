class CreateInstitutionHierarchies < ActiveRecord::Migration
  def up
  	create_table :institution_hierarchies, :id => false do |t|
      t.integer  :ancestor_id, :null => false   # ID of the parent/grandparent/great-grandparent/... tag
      t.integer  :descendant_id, :null => false # ID of the target tag
      t.integer  :generations, :null => false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    add_index :institution_hierarchies, [:ancestor_id, :descendant_id, :generations],
      :unique => true, :name => "institution_anc_desc_udx"

    # For "all ancestors of…" selects,
    add_index :institution_hierarchies, [:descendant_id],
      :name => "institution_desc_idx"

  end

  def down
  	remove_index :institution_hierarchies, [:ancestor_id, :descendant_id, :generations]
  	drop_table :institution_hierarchies
  end
end
