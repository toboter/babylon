class Pailful < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :asset_id, :bucket_id

  after_destroy :reset_cover

  stampable

  belongs_to :asset
  belongs_to :bucket

  def reset_cover
  	if bucket.cover_asset_id == asset_id
  	  Bucket.update(bucket, :cover_asset_id => Bucket.find(bucket).assets.first.id)
  	end
  end

end
