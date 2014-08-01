class ItemConnection < ActiveRecord::Base
  attr_accessible :predicate_id, :inverse_item_id

  belongs_to :item
  belongs_to :inverse_item, class_name: 'Item'

  belongs_to :predicate

  stampable
end
