class Study < ActiveRecord::Base
  attr_accessible :properties, :studyable_id, :studyable_type, :list_id, :citations_attributes

  stampable

  serialize :properties, ActiveRecord::Coders::Hstore

  belongs_to :list
  belongs_to :studyable, :polymorphic => true

  has_many :buckets, as: :attachable
  has_many :assets, through: :buckets

  has_many :citations, as: :citable
  accepts_nested_attributes_for :citations, allow_destroy: true
  has_many :references, through: :citations

  has_many :documents, as: :documentable, dependent: :destroy
  has_many :issues, as: :issuable, dependent: :destroy

  validates :list_id, presence: true
  validates :list_id, :uniqueness => {scope: [:studyable_type, :studyable_id], :message => 'List does not accept duplicates'}, :unless => :accept_duplicates
  validate :validate_properties

  def accept_duplicates
  	list.accept_duplicates
  end

  def validate_properties
    list.project.studyfields.each do |field|
      if field.required? && properties[field.name].blank?
        errors.add field.name, "must not be blank"
      end
    end
  end

  def name
  	'Study of '+studyable.name
  end

  # Ransack attribute, convert & concatenat definitions
  def self.ransackable_attributes auth_object = nil
    %w(properties) + _ransackers.keys
  end

end
