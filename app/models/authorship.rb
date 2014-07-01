class Authorship < ActiveRecord::Base
  attr_accessible :person_name_id, :position, :predicate_id, :reference_id, :creator_id, :updater_id, :person_name_name

  default_scope :order => 'position'

  stampable
  acts_as_list :scope => :reference

  belongs_to :person_name
  belongs_to :reference

  validates_uniqueness_of :person_name_id, :scope => :reference_id

  def person_name_name
    person_name.try(:name)
  end

  def person_name_name=(name)
  	split = name.split(' ', 2)
  	first_name = split.first
  	last_name = split.last
    self.person_name = PersonName.where(first_name: first_name, last_name: last_name).first_or_create if name.present?

  end

end
