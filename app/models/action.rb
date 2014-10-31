class Action < ActiveRecord::Base
  attr_accessible :target, :actable_id, :actable_type, :source_id, :predicate_id, 
  				  :creator_id, :updater_id

  stampable

  belongs_to :actable, :polymorphic => true
  belongs_to :person
  belongs_to :predicate
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :source

  has_many :buckets, through: :source
  has_many :documents, through: :source

  validates_presence_of :predicate_id

  after_create { Activity.create(user: creator, action: 'add', trackable: actable, targetable: self) }

  def name
    "#{actable.name} (#{predicate.name})"
  end
end
