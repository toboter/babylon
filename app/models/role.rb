class Role < ActiveRecord::Base
  attr_accessible :role, :user_id, :creator_id, :updater_id

  stampable

  belongs_to :user

  validates_uniqueness_of :user_id
  validates_presence_of :user_id, :role
end
