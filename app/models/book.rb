class Book < ActiveRecord::Base
  attr_accessible :editor_ids, :book_identifier, :book_type, :place, :publisher, :serial_id, :title, :volume, 
                  :unpublished, :year, :uri, :creator_id, :updater_id, :articles_attributes, :editorships_attributes

  stampable

  default_scope order('year DESC')

  has_many :articles, :class_name => 'Reference', :dependent => :destroy
  has_many :editors, :class_name => 'Person', through: :editorships, :source => :person
  has_many :editorships, :dependent => :destroy
  belongs_to :serial
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  accepts_nested_attributes_for :articles, :reject_if => lambda { |a| a[:title].blank? }, allow_destroy: true
  accepts_nested_attributes_for :editorships, allow_destroy: true

  validates_presence_of :book_type
  validates_presence_of :year, :unless => "unpublished == true"
  validates_presence_of :title, unless: :book_title_not_needed?
  validates_presence_of :volume, if: :book_is_serial?
  validates_uniqueness_of :book_identifier, :allow_blank => true, :message => "The Identifier is already taken"
  #validates_associated Die Validierung des genesteten Artikels erfolgt über reject_if

  BOOKTYPES = %w[Monographie Sammelband Monographie\ in\ einer\ Reihe Sammelband\ in\ einer\ Reihe Band\ einer\ Zeitschrift]

  def book_title_not_needed?
    book_type == 'Monographie' || book_type == 'Monographie in einer Reihe' || book_type == 'Band einer Zeitschrift'
  end

  def book_is_serial?
    book_type == 'Band einer Zeitschrift' || book_type == "Sammelband in einer Reihe" || book_type == 'Monographie in einer Reihe'
  end


  def self.ransackable_attributes(auth_object = nil)
    %w( title year ) + _ransackers.keys
  end

end