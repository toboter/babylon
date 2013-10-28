class TodoDependency < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :todo_id, :depends_on_id
  belongs_to :todo
  belongs_to :dependency, class_name: "Todo", foreign_key: :depends_on_id

  stampable
end
