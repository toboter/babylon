class CollectionField < ActiveRecord::Base
  attr_accessible :field_type, :required, :creator_id, :updater_id, :name, :select_values_attributes

  stampable
  default_scope order('name ASC')

  belongs_to :collection
  has_many :select_values, class_name: 'CollectionFieldValue'

  accepts_nested_attributes_for :select_values, allow_destroy: true

end
