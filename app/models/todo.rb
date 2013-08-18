class Todo < ActiveRecord::Base
  attr_accessible :assigned_id, :completed, :due_to, :name, :creator_id, :updater_id, :todolist_id

  stampable

  belongs_to :todolist
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :assigned, class_name: "User"

  validates_presence_of :name, :todolist_id
end
