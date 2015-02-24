class List < ActiveRecord::Base
  attr_accessible :description, :featured, :forkable, :forked_from_id, :name, :project_id, 
                  :accept_duplicates, :locations_attributes, :creator_id, :updater_id

  stampable

  belongs_to :project
  belongs_to :forked_from, class_name: 'List'
  has_many :studies, dependent: :destroy
  has_many :locations, as: :locatable, dependent: :destroy

  accepts_nested_attributes_for :locations, allow_destroy: true

  # Ransack attribute, convert & concatenat definitions
  def self.ransackable_attributes auth_object = nil
    %w(name description) + _ransackers.keys
  end
end
