class Asset < ActiveRecord::Base
  attr_accessible :assetfile, :content_type, :file_datetime, :file_name, :file_size, :name, :parent_id, :file_author, :creator_id, :updater_id
  
  stampable
  mount_uploader :assetfile, AssetfileUploader

  has_many :buckets, through: :pailfuls
  has_many :pailfuls, :dependent => :destroy
end
