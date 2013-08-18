class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, 
         :authentication_keys => [:login]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :username, :login
  # attr_accessible :title, :body

  has_many :people
  has_one :role, :dependent => :destroy
  has_many :projects, through: :memberships
  has_many :memberships, :dependent => :destroy
  has_many :todos, foreign_key: "assigned_id"
  has_many :in_todolists, source: "todolist", through: :todos, uniq: true

  # Virtual attribute for authenticating by either username or email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login
  after_create :add_base_role
  before_destroy :not_destroy_admin

  model_stamper

  ROLES = %w[guest fellow author editor admin]

  def role?(base_role)
    role.present? && ROLES.index(base_role.to_s) <= ROLES.index(role.role)
  end

  def add_base_role
    Role.create :role => "guest", :user_id => self.id
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
    if people.first
      people.first.fullname
    else
     username
   end
  end

  def not_destroy_admin
    if role.role == 'admin'
      errors.add(:base, "You cannot destroy the last admin!")
      return false
    end
  end
end
