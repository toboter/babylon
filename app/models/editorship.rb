class Editorship < ActiveRecord::Base
  belongs_to :book
  belongs_to :person
  attr_accessible :creator_id, :updater_id, :book_id, :person_id

  stampable

end
