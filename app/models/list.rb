class List < ActiveRecord::Base
  attr_accessible :description, :featured, :forkable, :forked_from_id, :name, :project_id, :accept_duplicates

  stampable

  belongs_to :project
  belongs_to :forked_from, class_name: 'Project'
  has_many :studies

  validates :project_id, presence: true


  # Ransack attribute, convert & concatenat definitions
  def self.ransackable_attributes auth_object = nil
    %w(name description) + _ransackers.keys
  end
end
