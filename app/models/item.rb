class Item < ActiveRecord::Base
  extend FriendlyId
  friendly_id :inventory_name, use: [:slugged, :history]
  
  attr_accessible :collection_id, :classification_id, :inventory_number, :inventory_number_index, 
            :context_id, :accession_date, :creator_id, :updater_id, :title, :tag_ids, 
            :citations_attributes, :actions_attributes, :description, :slug

  stampable

  after_create :add_description

  belongs_to :collection
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :classification, class_name: 'ItemClassification', foreign_key: 'classification_id'
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :buckets, as: :attachable
  has_many :assets, through: :buckets
  has_many :citations, as: :citable
  has_many :references, through: :citations
  # has_many :measurements, as: measureable
  has_many :actions, as: :actable
  # has_many :connections, as: :connectable
  has_many :documents, as: :documentable
  has_many :issues, as: :issuable, dependent: :destroy

  has_many :studyassignments, :dependent => :destroy
  has_many :projects, through: :studyassignments

  validates_presence_of :collection_id, :inventory_number
  validates :inventory_number, :uniqueness => {:scope => :inventory_number_index}

  accepts_nested_attributes_for :citations, allow_destroy: true
  accepts_nested_attributes_for :actions, allow_destroy: true

  def inventory_name
  	collection.shortcut+' '+inventory_number+inventory_number_index
  end

  def name
  	inventory_name
  end

end
