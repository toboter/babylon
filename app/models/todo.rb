class Todo < ActiveRecord::Base
  attr_accessible :assigned_id, :completed, :due_to_text, :name, :creator_id, :updater_id, 
                  :project_id, :depends_on, :starts_at_text, :todo_dependencies_attributes

  stampable

  attr_writer :due_to_text, :starts_at_text

  belongs_to :project
  belongs_to :dependent, class_name: "Todo", foreign_key: "depends_on"
  has_many :todo_dependencies
  has_many :dependencies, through: :todo_dependencies
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  belongs_to :assigned, class_name: "User"
  has_many :issues, as: :issuable, dependent: :destroy

  accepts_nested_attributes_for :todo_dependencies, allow_destroy: true

  validates_presence_of :name, :assigned, :due_to_text
  validate :check_due_to_text, :check_starts_at_text

  before_save :save_due_to_text, :save_starts_at_text

  def due_to_text
    @due_to_text || due_to.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end

  def starts_at_text
    @starts_at_text || starts_at.try(:strftime, "%Y-%m-%d %H:%M:%S")
  end
  
  def save_due_to_text
    self.due_to = Time.zone.parse(@due_to_text) if @due_to_text.present?
  end

  def save_starts_at_text
    self.starts_at = Time.zone.parse(@starts_at_text) if @starts_at_text.present?
  end

  def check_due_to_text
    if @due_to_text.present? && Time.zone.parse(@due_to_text).nil?
      errors.add :due_to_text, "cannot be parsed"
    end
  rescue ArgumentError
    errors.add :due_to_text, "is out of range"
  end

  def check_starts_at_text
    if @starts_at_text.present? && Time.zone.parse(@starts_at_text).nil?
      errors.add :starts_at_text, "cannot be parsed"
    end
  rescue ArgumentError
    errors.add :starts_at_text, "is out of range"
  end
end
