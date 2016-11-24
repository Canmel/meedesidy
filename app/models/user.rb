class User < ActiveRecord::Base
  rolify
  validate :password, on: :create
  has_and_belongs_to_many :roles, join_table: :users_roles
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
