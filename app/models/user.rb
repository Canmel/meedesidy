class User < ActiveRecord::Base
  rolify

  has_and_belongs_to_many :roles, :join_table => :users_roles
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  enum status: { active: 1, archived: 0 }

  validate :password, on: :create
  validates :name, presence: true, length: { maximum: 14 }
  validate :valid_user_roles

  def valid_user_roles
    errors.add(:role_ids, '至少有一个角色') if roles.size.zero?
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && user.active? && BCrypt::Engine.hash_secret(password, user.salt) == user.password_digest
      return user
    end
    false
  end
end
