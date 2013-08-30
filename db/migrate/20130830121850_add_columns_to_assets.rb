class AddColumnsToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :caption, :text
    remove_column :assets, :file_datetime
    add_column :assets, :date_taken, :string
    add_column :assets, :latitude, :float
    add_column :assets, :longitude, :float
    add_column :assets, :width, :integer
    add_column :assets, :height, :integer
    add_column :assets, :camera, :string
    add_column :assets, :camera_make, :string
    add_column :assets, :flash, :string
    add_column :assets, :focal_length, :string
    add_column :assets, :exposure, :string
    add_column :assets, :f_number, :string
    add_column :assets, :iso, :string
    add_column :assets, :license, :string
  end
end
