class Action < ActiveRecord::Base
  attr_accessible :actable_date_text, :actable_id, :actable_type, :person_id, :predicate_id, :creator_id, :updater_id

  stampable

  belongs_to :actable, :polymorphic => true
  belongs_to :person
  belongs_to :predicate
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  validates_presence_of :actable_id, :actable_type, :person_id, :predicate_id


  attr_writer :actable_date_text

  validate :check_actable_date_text

  before_save :save_actable_date_text

  def actable_date_text
    @actable_date_text || actable_date.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end
  
  def save_actable_date_text
    self.actable_date = Time.zone.parse(@actable_date_text) if @actable_date_text.present?
  end

  def check_actable_date_text
    if @actable_date_text.present? && Time.zone.parse(@actable_date_text).nil?
      errors.add :actable_date_text, "cannot be parsed"
    end
  rescue ArgumentError
    errors.add :actable_date_text, "is out of range"
  end
end
