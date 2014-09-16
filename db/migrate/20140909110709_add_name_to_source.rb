class AddNameToSource < ActiveRecord::Migration
  def change
    add_column :sources, :name, :string
  end
end
