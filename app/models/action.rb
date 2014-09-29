class Action < ActiveRecord::Base
  attr_accessible :actable_date_text, :actable_id, :actable_type, :person_id, :predicate_id, 
  				  :creator_id, :updater_id, :locations_attributes, :source_assignments_attributes

  stampable

  belongs_to :actable, :polymorphic => true
  belongs_to :person
  belongs_to :predicate
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  has_many :locations, as: :locatable, dependent: :destroy
  has_many :source_assignments, dependent: :destroy
  has_many :sources, through: :source_assignments
  has_many :buckets, through: :sources
  has_many :documents, through: :sources

  validates_presence_of :person_id, :predicate_id, :actable_id, :actable_type

  accepts_nested_attributes_for :locations, allow_destroy: true
  accepts_nested_attributes_for :source_assignments, allow_destroy: true

  after_create { Activity.create(user: creator, action: 'add', trackable: actable, targetable: self) }

  def name
    "#{actable.name} (#{predicate.name} #{person.name})"
  end
end
