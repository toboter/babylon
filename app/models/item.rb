class Item < ActiveRecord::Base
  attr_accessible :collection_id, :accession_number, :accession_number_index, :context_id, 
  				  :accession_date, :creator_id, :updater_id, :title, :tag_ids, :citations_attributes

  stampable

  belongs_to :collection
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :buckets, as: :attachable
  has_many :assets, through: :buckets
  has_many :citations, as: :citable
  has_many :references, through: :citations
  # has_many :measurements, as: measureable
  # has_many :actions, as: :actable
  # has_many :connections, as: :connectable
  has_many :documents, as: :documentable
  has_many :comments, as: :commentable

  validates_presence_of :collection_id, :accession_number
  validates :accession_number, :uniqueness => {:scope => :accession_number_index}

  accepts_nested_attributes_for :citations, allow_destroy: true

  def accession_name
  	collection.shortcut+' '+accession_number+accession_number_index
  end

  def name
  	accession_name
  end

end
