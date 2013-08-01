class Book < ActiveRecord::Base
  attr_accessible :editor_ids, :book_identifier, :book_type, :place, :publisher, :serial_id, :title, :volume, 
                  :unpublished, :year, :uri, :creator_id, :updater_id, :articles_attributes, :editorships_attributes

  stampable

  validates_presence_of :book_type
  validates_presence_of :year, :unless => "unpublished == true"
  validates_presence_of :title, :unless => "book_type == 'Monographie' || book_type == 'Monographie in einer Reihe' || book_type == 'Band einer Zeitschrift'"

  has_many :articles, :class_name => 'Reference', :dependent => :destroy
  has_many :editors, :class_name => 'Person', through: :editorships, :source => :person
  has_many :editorships, :dependent => :destroy
  belongs_to :serial

  accepts_nested_attributes_for :articles, allow_destroy: true
  accepts_nested_attributes_for :editorships, allow_destroy: true

  BOOKTYPES = %w[Monographie Sammelband Monographie\ in\ einer\ Reihe Sammelband\ in\ einer\ Reihe Band\ einer\ Zeitschrift]



end