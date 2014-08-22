class RemoveLocationFromLists < ActiveRecord::Migration
  def up
  	remove_column :lists, :latitude
  	remove_column :lists, :longitude
  	remove_column :lists, :gmaps
  end

  def down
  	add_column :lists, :latitude, :float
  	add_column :lists, :longitude, :float
  	add_column :lists, :gmaps, :boolean
  end
end
