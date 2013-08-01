class Reference < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :title, :author_ids, :original_date, :alternative_author, :slug,
                  :first_page, :last_page, :book_id, :uri, :authorships_attributes

  stampable


  validates_presence_of :title
  validates_presence_of :book_id, :unless => :uri?

  has_many :authors, :class_name => 'Person', through: :authorships, :source => :person
  has_many :authorships, :dependent => :destroy, :order => 'position'
  belongs_to :book

  accepts_nested_attributes_for :authorships, allow_destroy: true



end
