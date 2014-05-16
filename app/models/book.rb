class Book < ActiveRecord::Base
  attr_accessible :editorships_attributes, :book_identifier, :book_type, :place, :publisher, :serial_id, :title, :volume, 
                  :unpublished, :year, :uri, :creator_id, :updater_id, :articles_attributes, :edition, :abbreviation

  stampable

  default_scope order('year DESC')

  has_many :articles, :class_name => 'Reference', :dependent => :destroy, :order => 'first_page'

  has_many :editorships, :dependent => :destroy
  has_many :editors, :class_name => 'PersonName', through: :editorships, :source => :person_name, :order => 'editorships.position'

  belongs_to :serial
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  accepts_nested_attributes_for :articles, allow_destroy: true
  accepts_nested_attributes_for :editorships, allow_destroy: true

  validates_presence_of :book_type
  validates_presence_of :year, :unless => "unpublished == true"
  validates_presence_of :title, unless: :book_title_not_needed?
  validates_presence_of :volume, if: :book_is_serial?
  validates_uniqueness_of :book_identifier, :allow_blank => true, :message => "The Identifier has already been taken"
  #validates_associated Die Validierung des genesteten Artikels erfolgt über reject_if

  BOOKTYPES = %w[Monograph Collection Monograph\ in\ a\ serial Collection\ in\ a\ serial Issue\ of\ a\ journal]
  # "Proceeding" "Reference book"
  # -> in monograph, in collection, in proceedings, in journal, in reference book

  def book_title_not_needed?
    book_type == 'Monograph' || book_type == 'Monograph in a serial' || book_type == 'Issue of a journal'
  end

  def book_is_serial?
    book_type == 'Issue of a journal' || book_type == "Collection in a serial" || book_type == 'Monograph in a serial'
  end

end