class Document < ActiveRecord::Base
  attr_accessible :content, :document_type, :documentable_id, :documentable_type, :title, 
  				  :creator_id, :updater_id, :abstract, :tag_ids

  stampable

  belongs_to :documentable, :polymorphic => true
  belongs_to :page, foreign_key: "documentable_id", conditions: "documentable_type = 'Page'"
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  has_many :comments, as: :commentable, :dependent => :destroy
  has_many :taggings, as: :taggable, :dependent => :destroy
  has_many :tags, through: :taggings

  GENERALDOCUMENTTYPES = %w[Introduction]
  PEOPLEDOCUMENTTYPES = %w[General\ Information Curriculum\ Vitae]
  ITEMDOCUMENTTYPES = %w[Description]

  DOKUMENTTYPES = GENERALDOCUMENTTYPES+PEOPLEDOCUMENTTYPES+ITEMDOCUMENTTYPES

  validates_presence_of :title, :unless => :document_type?
  validates_presence_of :content, :unless => :page?, :unless => :item_description? # wenn diese validierung eintritt können pages nicht mehr automatisch erstellt werden.
  validates_uniqueness_of :document_type, :allow_blank => true, :scope => [:documentable_id, :documentable_type]
  validates_uniqueness_of :title, :scope => [:documentable_id, :documentable_type]

  def self.doctype(type)
    where(:document_type => type).first
  end

  scope :without_document_type, where('document_type NOT IN (?)', Document::DOKUMENTTYPES)

  def page?
    documentable_type == 'Page'
  end

  def person?
    documentable_type == 'Person'
  end

  def item_description?
    document_type == 'Description'
  end

  def title_readonly?
    page? || person? || (document_type == 'Introduction') || item_description?
  end

end
