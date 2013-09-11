class Reference < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :title, :author_ids, :original_date, :alternative_author, :slug,
                  :first_page, :last_page, :book_id, :uri, :authorships_attributes

  stampable


  validates_presence_of :title
  validates_presence_of :book_id, :unless => :uri?

  has_many :authors, :class_name => 'Person', through: :authorships, :source => :person
  has_many :authorships, :dependent => :destroy, :order => 'position'
  has_many :documents, as: :documentable
  has_many :buckets, as: :attachable
  has_many :assets, through: :buckets
  belongs_to :book
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  
  accepts_nested_attributes_for :authorships, allow_destroy: true

  def name
    title
  end

  def self.ransackable_attributes(auth_object = nil)
    %w( title ) + _ransackers.keys
  end

end
