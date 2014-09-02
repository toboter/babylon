class Action < ActiveRecord::Base
  attr_accessible :actable_date_text, :actable_id, :actable_type, :person_id, :predicate_id, 
  				  :creator_id, :updater_id

  stampable

  belongs_to :actable, :polymorphic => true
  belongs_to :person
  belongs_to :predicate
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  validates_presence_of :person_id, :predicate_id

end
