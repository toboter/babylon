class Document < ActiveRecord::Base
  attr_accessible :content, :document_type, :documentable_id, :documentable_type, :title, 
  				  :creator_id, :updater_id, :abstract, :tag_ids

  stampable

  belongs_to :documentable, :polymorphic => true
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  has_many :comments, as: :commentable, :dependent => :destroy
  has_many :taggings, as: :taggable, :dependent => :destroy
  has_many :tags, through: :taggings

  GENERALDOCUMENTTYPES = %w[Introduction]
  DOKUMENTTYPES = GENERALDOCUMENTTYPES

  validates_presence_of :title, :unless => :document_type?
  validates_presence_of :content
  validates_uniqueness_of :document_type, :allow_blank => true, :scope => [:documentable_id, :documentable_type]
  validates_uniqueness_of :title, :scope => [:documentable_id, :documentable_type]

  def self.doctype(type)
    where(:document_type => type).first
  end

  scope :without_document_type, where('document_type NOT IN (?)', Document::DOKUMENTTYPES)

  def title_readonly?
    (document_type == 'Introduction')
  end

end
