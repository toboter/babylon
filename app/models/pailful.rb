class Pailful < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :asset_id, :bucket_id

  after_destroy :reset_cover

  stampable

  belongs_to :asset
  belongs_to :bucket

  def reset_cover
    asset = Bucket.find(bucket).assets.first
  	if asset.present? && bucket.cover_asset_id == asset_id
  	  Bucket.update(bucket, :cover_asset_id => asset.id)
    elsif asset.blank?
      Bucket.update(bucket, :cover_asset_id => nil)
  	end
  end

end
