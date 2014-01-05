class Predicate < ActiveRecord::Base
  attr_accessible :description, :inverse_name, :name, :scope_type
end
