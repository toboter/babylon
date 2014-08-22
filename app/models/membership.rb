class Membership < ActiveRecord::Base
  attr_accessible :role, :user_id, :project_id, :creator_id, :updater_id

  stampable

  belongs_to :user
  belongs_to :project

  validates :user_id, uniqueness: { scope: :project_id, message: 'You cannot add a member twice' }
  validates :user_id, :role, presence: true

  ROLES = %w[student fellow member admin]

end
