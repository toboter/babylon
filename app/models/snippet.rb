class Snippet < ActiveRecord::Base
  attr_accessible :description, :pinned, :snippet_type, :creator_id, :updater_id, :name

  stampable

  validates_presence_of :snippet_type, :description, :name
  # validates_uniqueness_of :name, scope: :snippet_type

  has_many :documents, as: :documentable, dependent: :destroy
  has_many :buckets, as: :attachable, :dependent => :destroy
  has_many :assets, through: :buckets  
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  SNIPPETTYPES = %w[news]

end
