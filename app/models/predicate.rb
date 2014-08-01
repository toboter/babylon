class Predicate < ActiveRecord::Base
  attr_accessible :description, :inverse_name, :name, :scope_type, :creator_id, :updater_id, :project_id

  stampable

  has_many :citations

  validates_presence_of :name, :inverse_name, :scope_type
  validates_uniqueness_of :name, scope: :scope_type
  validates_uniqueness_of :inverse_name, scope: :scope_type

  SCOPE_TYPES = %w{Action Citation Attribute\ type Item\ connection}
end
