class PersonName < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :person_id, :primary

  attr_reader :name

  stampable

  belongs_to :person
  has_many :authorships, :dependent => :destroy
  has_many :editorships, :dependent => :destroy

  validates_presence_of :first_name, :last_name

  def name
  	"#{first_name} #{last_name}"
  end

end
