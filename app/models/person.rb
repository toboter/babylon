class Person < ActiveRecord::Base
  extend FriendlyId
  friendly_id :name, use: [:slugged, :history]

  attr_accessible :user_id, :creator_id, :date_of_birth, :date_of_death, :gender, :grade, 
                  :nickname, :profession, :public_email, :updater_id,
                  :phone, :fax, :uri, :institution_id, :show_inst_address, :affiliations_attributes,
                  :names_attributes, :cv, :general
  
  stampable

  after_create :build_profile_picture_bucket
  
  belongs_to :user
  belongs_to :creator, class_name: "User"
  belongs_to :updater, class_name: "User"

  has_many :names, :class_name => 'PersonName', :dependent => :destroy

  has_many :authorships, through: :names
  has_many :references, through: :authorships

  has_many :editorships, through: :names
  has_many :books, through: :editorships

  has_many :buckets, as: :attachable
  has_many :assets, through: :buckets
  has_many :documents, as: :documentable
  has_many :affiliations, :dependent => :destroy
  has_many :institutions, through: :affiliations
  
  validates_uniqueness_of :user_id, :allow_blank => true, :message => "is already connected to someone else"

  accepts_nested_attributes_for :names, allow_destroy: true
  accepts_nested_attributes_for :affiliations, allow_destroy: true

  scope :unconnected, where(:user_id => nil)

  GENDER = %w{female male}
  GRADES = %w{Prof.\ Dr. Dr. M.A.}

  def build_profile_picture_bucket
    Bucket.create :attachable_id => self.id, :attachable_type => "Person", :name => "Profile Pictures", :name_fixed => true
  end
  
  def name
    if names.where(primary: true).any?
      names.where(primary: true).first.name
    else
      names.first.name
    end
  end

  def profile_picture
    bucket = self.buckets.find_by_name('Profile Pictures')
    profile_picture = bucket.cover
  end

  def primary_or_first_institution
    if affiliations.where(primary: true).any?
      affiliations.where(primary: true).first.institution
    else
      affiliations.first.institution
    end
  end

  def self.search(search)
    if search
      where("concat(person_names.first_name, ' ', person_names.last_name) ILIKE ?", "%#{search}%")
    else
      scoped
    end
  end

  def name_with_profession
    profession.present? ? name + " (#{profession})" : name
  end

end
