class Serial < ActiveRecord::Base
  attr_accessible :name, :serial_type, :serial_identifier, :shortcut, :uri, :creator_id, :updater_id

  stampable

  validates_presence_of :name, :serial_type
  validates_uniqueness_of :serial_identifier, :allow_blank => true, :message => "The Identifier is already taken"
  validates_uniqueness_of :name, :uri
  validates_uniqueness_of :shortcut, :allow_blank => true

  has_many :books

  SERIALTYPES = %w[Zeitschrift Reihe]
end
