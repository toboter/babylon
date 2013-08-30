class AddMd5hashToAssets < ActiveRecord::Migration
  def change
    add_column :assets, :md5hash, :string
  end
end
