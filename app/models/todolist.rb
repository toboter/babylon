class Todolist < ActiveRecord::Base
  attr_accessible :name, :responsible_id, :creator_id, :updater_id, :project_id, :todos_attributes

  stampable

  belongs_to :project
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :responsible, class_name: "User"
  has_many :todos, dependent: :destroy

  validates_presence_of :name

  accepts_nested_attributes_for :todos, allow_destroy: true
  
end
