class DocumentSection < ActiveRecord::Base
  attr_accessible :content, :title, :creator_id, :updater_id

  stampable

  belongs_to :document
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
end
