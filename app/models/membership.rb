class Membership < ActiveRecord::Base
  attr_accessible :role, :user_id, :project_id, :creator_id, :updater_id

  stampable

  belongs_to :user
  belongs_to :project

  ROLES = %w[student fellow member admin]

end
