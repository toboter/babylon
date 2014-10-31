class Snippet < ActiveRecord::Base
  attr_accessible :snippet_type, :creator_id, :updater_id, :name, :content

  stampable

  validates_presence_of :snippet_type, :content, :name
  validates_uniqueness_of :snippet_type

  has_many :buckets, as: :attachable, :dependent => :destroy
  has_many :assets, through: :buckets  
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"


  SNIPPETTYPES = %w[about imprint help]

end
