class Page < ActiveRecord::Base
  attr_accessible :permalink, :creator_id, :updater_id

  stampable

  validates_presence_of :permalink
  validates_uniqueness_of :permalink

  has_many :documents, as: :documentable
  has_many :buckets, as: :attachable
  has_many :assets, through: :bucket
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  

end
