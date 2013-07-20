class Reference < ActiveRecord::Base
  attr_accessible :creator_id, :updater_id, :title, :person_ids, :original_date, :alternative_author, :slug,
                  :first_page, :last_page, :book_id, :uri

  stampable

  validates_presence_of :title
  validates_presence_of :person_ids, :unless => :alternative_author

  has_many :people, through: :authorships
  has_many :authorships, :dependent => :destroy
  belongs_to :book


end
