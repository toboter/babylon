class Pailful < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :asset_id, :bucket_id

  stampable

  belongs_to :asset
  belongs_to :bucket

end
