class Editorship < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :book_id, :person_name_id, :position
  
  stampable
  acts_as_list :scope => :book

  belongs_to :book
  belongs_to :person_name
end
