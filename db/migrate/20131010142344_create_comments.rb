class CreateComments < ActiveRecord::Migration
  def up
    create_table :comments do |t|
      t.integer :commentable_id
      t.string :commentable_type
      t.text :content
      t.integer :parent_id

      t.timestamps
      t.userstamps
    end
     create_table :comment_hierarchies, :id => false do |t|
      t.integer  :ancestor_id, :null => false   # ID of the parent/grandparent/great-grandparent/... tag
      t.integer  :descendant_id, :null => false # ID of the target tag
      t.integer  :generations, :null => false   # Number of generations between the ancestor and the descendant. Parent/child = 1, for example.
    end

    add_index :comment_hierarchies, [:ancestor_id, :descendant_id, :generations],
      :unique => true, :name => "comment_anc_desc_udx"

    # For "all ancestors of…" selects,
    add_index :comment_hierarchies, [:descendant_id],
      :name => "comment_desc_idx"
  end

  def down
  	remove_index :comment_hierarchies, [:ancestor_id, :descendant_id, :generations]
  	drop_table :comment_hierarchies
  	drop_table :comments
  end
end
