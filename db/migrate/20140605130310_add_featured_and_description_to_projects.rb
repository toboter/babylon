class AddFeaturedAndDescriptionToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :featured, :boolean
    add_column :projects, :description, :text
  end
end
