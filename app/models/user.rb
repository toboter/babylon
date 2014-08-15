class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login
  # attr_accessible :title, :body

  has_one :person
  has_one :role, :dependent => :destroy
  has_many :memberships, :dependent => :destroy
  has_many :projects, through: :memberships
  has_many :todos, foreign_key: "assigned_id"
  has_many :issues, foreign_key: "assigned_id"
  has_many :activities

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  after_create :add_base_role
  before_destroy :check_admin_status

  model_stamper

  validates :username, 
    length: { :minimum => 3, :maximum => 10 }, 
    presence: true,
    uniqueness: true,
    format: { :with => /\A[a-zA-Z]+\z/, message: "only letters allowed" }

  ABILITYROLES = %w[guest fellow author editor admin superuser]
  ROLES = %w[guest fellow author editor admin]

  scope :without_user, lambda{|user| user ? {:conditions => ["users.id != ?", user.id]} : {}}
  # named_scope :not_in_forums, lambda { |forums| { :conditions => ['forum_id not in (?)', forums.select(&:id).join(',')] }

  def role?(base_role)
    role.present? && ABILITYROLES.index(base_role.to_s) <= ABILITYROLES.index(role.role)
  end

  def superuser?
    self.role.role == 'superuser'
  end

  def add_base_role
    Role.create :role => "guest", :user_id => self.id unless self.username == 'toboter'
  end

  def self.find_first_by_auth_conditions(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions).first
    end
  end

  def available_name
    if person
      person.name
    else
     username
   end
  end

  def check_admin_status
    if role.role == 'superuser'
      errors.add(:base, "You cannot destroy the admin!")
      return false
    else
      errors.add(:base, "You cannot destroy any user! This is an implementation error. Perhaps there are records associated to the user in question.")
      return false
    end
  end

end
