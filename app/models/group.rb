class Group < ActiveRecord::Base
  attr_accessible :name, :area_id, :creator_id, :updater_id

  stampable

  has_many :projects, as: :projectable
  has_many :documents, as: :documentable
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :area

end
