class Document < ActiveRecord::Base
  attr_accessible :abstract, :document_type, :documentable_id, :documentable_type, :title, 
  				  :creator_id, :updater_id, :document_sections_attributes

  stampable

  has_many :document_sections
  belongs_to :documentable, :polymorphic => true
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"


  GENERALDOCUMENTTYPES = %w[Introduction About]
  PEOPLEDOCUMENTTYPES = %w[General/ Information Curriculum/ Vitae]

  DOKUMENTTYPES = GENERALDOCUMENTTYPES+PEOPLEDOCUMENTTYPES

  validates_presence_of :title, :unless => :document_type?
  validates_uniqueness_of :document_type, :allow_blank => true, :scope => [:documentable_id, :documentable_type]

  accepts_nested_attributes_for :document_sections, allow_destroy: true

  def self.introduction
    where(:document_type => 'Introduction').first
  end

  scope :all_but_typelist, where('document_type NOT IN (?)', Document::DOKUMENTTYPES)

end
