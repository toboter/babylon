class Serial < ActiveRecord::Base
  attr_accessible :name, :serial_type, :serial_identifier, :shortcut, :uri, :creator_id, :updater_id

  stampable

  validates_presence_of :name, :serial_type
  validates_uniqueness_of :serial_identifier, :allow_blank => true, :message => "The Identifier is already taken"
  validates_uniqueness_of :name
  validates_uniqueness_of :uri, :allow_blank => true
  validates_uniqueness_of :shortcut, :allow_blank => true

  has_many :books, dependent: :destroy
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  SERIALTYPES = %w[Journal Serial]

  def serial_types
    if serial_type == 'Journal'
      %w[Issue\ of\ a\ journal]
    else
      %w[Monograph\ in\ a\ serial Collection\ in\ a\ serial]
    end
  end

end
