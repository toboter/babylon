class Citation < ActiveRecord::Base
  attr_accessible :predicate_id, :ref_target, :creator_id, :updater_id, :citable_id, :citable_type, :reference_id

  stampable

  validates :predicate, presence: true

  belongs_to :reference
  belongs_to :citable, :polymorphic => true
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :predicate

end
