class Affiliation < ActiveRecord::Base
  attr_accessible :from, :primary, :to, :person_id, :institution_id, :creator_id, :updater_id

  belongs_to :person
  belongs_to :institution

  stampable

  validates_uniqueness_of :primary, scope: :person_id, allow_blank: true, message: 'You can only have one primary institution'
  validates_uniqueness_of :institution_id, scope: :person_id

end
