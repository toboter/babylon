class Page < ActiveRecord::Base
  attr_accessible :permalink, :creator_id, :updater_id

  stampable

  validates_presence_of :permalink
  validates_uniqueness_of :permalink

  def to_param
    permalink
  end

  has_many :documents, as: :documentable, dependent: :destroy
  has_many :buckets, as: :attachable, dependent: :destroy
  has_many :assets, through: :bucket
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  

end
