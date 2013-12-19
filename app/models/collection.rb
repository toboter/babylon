class Collection < ActiveRecord::Base
  attr_accessible :name, :shortcut, :creator_id, :updater_id, :institution_id

  stampable

  belongs_to :institution
  has_many :items

  validates_presence_of :name, :shortcut
  validates_uniqueness_of :name, :shortcut
  

end
