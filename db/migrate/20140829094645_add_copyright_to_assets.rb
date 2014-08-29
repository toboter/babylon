class AddCopyrightToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :copyright_institution_id, :integer
  end
end
