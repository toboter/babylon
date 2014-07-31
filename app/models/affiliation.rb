class Affiliation < ActiveRecord::Base
  attr_accessible :from, :to, :person_id, :institution_id, :creator_id, :updater_id, :primary

  belongs_to :person
  belongs_to :institution

  stampable

  validates_uniqueness_of :institution_id, scope: :person_id
  validates_uniqueness_of :primary, scope: :person_id, :allow_blank => true

end
