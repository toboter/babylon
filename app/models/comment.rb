class Comment < ActiveRecord::Base
  attr_accessible :content, :issue_id, :creator_id, :updater_id

  stampable

  belongs_to :issue
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  validates :content, presence: true
end
