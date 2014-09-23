class AddDetailsToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :changes_content, :text
    add_column :activities, :targetable_type, :string
    add_column :activities, :targetable_id, :integer

    add_index :activities, :targetable_id
  end
end
