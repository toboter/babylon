class Asset < ActiveRecord::Base
  attr_accessible :assetfile, :content_type, :file_datetime, :file_name, :file_size, :name, :parent_id, :file_author, :creator_id, :updater_id
  
  stampable
  mount_uploader :assetfile, AssetfileUploader

  before_validation :update_asset_attributes

  has_many :buckets, through: :pailfuls
  has_many :pailfuls, :dependent => :destroy

  validates_presence_of :assetfile, :name, :content_type


  def self.has_cover_id(cover_id)
    where('id = ?', cover_id).first
  end

  private
  
  def update_asset_attributes
    if assetfile.present? && assetfile_changed?
      self.content_type = assetfile.file.content_type
      self.file_size = assetfile.file.size
    end
  end
end
