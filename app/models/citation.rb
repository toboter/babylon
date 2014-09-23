class Citation < ActiveRecord::Base
  attr_accessible :ref_target, :creator_id, :updater_id, :citable_id, :citable_type, :reference_id, :predicate_id

  stampable

  belongs_to :reference
  belongs_to :predicate
  belongs_to :citable, :polymorphic => true
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  after_create {Activity.create(user: creator, action: 'add', trackable: citable, targetable: reference)}

end
