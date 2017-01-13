class User < ActiveRecord::Base
  rolify
  validate :password, on: :create
  validates :name, presence: true, length: { maximum: 14 }
  validate :valid_user_roles
  has_and_belongs_to_many :roles, join_table: :users_roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  enum status: { active: 1, archived: 0 }

  def valid_user_roles
    errors.add(:role_ids, '至少有一个角色') if roles.size.zero?
  end
end
