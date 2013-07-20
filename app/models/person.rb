class Person < ActiveRecord::Base
  attr_accessible :user_id, :creator_id, :date_of_birth, :date_of_death, :first_name, :gender, :grade, :last_name, :nickname, :profession, :public_email, :updater_id, :engagements_attributes
  
  stampable

  after_create :build_profile_picture_bucket
  
  belongs_to :user
  has_many :engagements
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"
  has_many :authorships, :dependent => :destroy
  has_many :references, through: :authorships
  has_many :editorships, :dependent => :destroy
  has_many :books, through: :editorships
  has_many :buckets, as: :attachable

  accepts_nested_attributes_for :engagements, allow_destroy: true

  validates_presence_of :first_name, :last_name
  validates_uniqueness_of :user_id, :allow_blank => true, :message => "is already connected to someone else"

  scope :unconnected, where(:user_id => nil)

  GENDER = %w{female male}

  def build_profile_picture_bucket
    Bucket.create :attachable_id => self.id, :attachable_type => "Person", :name => "Profile Pictures", :name_fixed => true
  end

  def fullname
  	"#{first_name} #{last_name}"
  end
  
end
