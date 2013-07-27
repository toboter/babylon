class Area < ActiveRecord::Base
  attr_accessible :name, :creator_id, :updater_id

  stampable

  has_many :groups
end
