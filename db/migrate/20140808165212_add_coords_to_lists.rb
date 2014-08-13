class AddCoordsToLists < ActiveRecord::Migration
  def change
  	add_column :lists, :latitude, :float
  	add_column :lists, :longitude, :float
  	add_column :lists, :gmaps, :boolean
  end
end
