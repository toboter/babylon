class PersonName < ActiveRecord::Base
  attr_accessible :first_name, :last_name, :person_id, :primary

  attr_reader :name

  stampable

  belongs_to :person
  has_many :authorships, :dependent => :destroy
  has_many :editorships, :dependent => :destroy

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :primary, scope: :person_id, :allow_blank => true

  def name
  	"#{first_name} #{last_name}"
  end

  def name_with_profession
    person.profession.present? ? name + " (#{person.profession})" : name
  end

end
