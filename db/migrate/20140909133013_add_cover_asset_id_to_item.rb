class AddCoverAssetIdToItem < ActiveRecord::Migration
  def change
    add_column :items, :cover_asset_id, :integer
    remove_column :items, :accession_date
    remove_column :items, :excavation_date
  end
end
