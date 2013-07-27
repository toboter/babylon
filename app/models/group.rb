class Group < ActiveRecord::Base
  attr_accessible :name, :area_id, :creator_id, :updater_id

  stampable

  belongs_to :area
  has_many :projects

end
