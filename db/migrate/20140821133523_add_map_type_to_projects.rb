class AddMapTypeToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :map_type, :string
  end
end
