class CollectionFieldValue < ActiveRecord::Base
  attr_accessible :field_value, :creator_id, :updater_id, :description

  belongs_to :collection_field

  stampable
end
