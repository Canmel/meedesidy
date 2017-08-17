class User < ActiveRecord::Base
  HALF_HOUR_SECOND = 108000
  rolify

  has_and_belongs_to_many :roles, :join_table => :users_roles
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  attr_accessor :dept

  enum status: { active: 1, archived: 0 }

  validates :password, length: 6..20, presence: true, on: :create
  validates :email, presence: true, uniqueness: true
  validates :name, presence: true, length: { maximum: 14 }, on: :update
  # validate :valid_user_roles

  # after_save 将回调函数包含在同一个事务中，那么要么全部成功，要么全部失败。回调函数中的抛出的异常会导致整个操作失败
  after_create :create_qrcode

  after_update :update_qrcode

  # after_commit 是在事务提交之后，再进行的处理，那么即使回调函数抛出异常，也不会导致之前的操作失败
  after_commit :do_sth_after_commit, on: [:create, :update]

  # after_rollback

  def valid_user_roles
    errors.add(:role_ids, '至少有一个角色') if Rails.env.development? && roles.size.zero? && name.present?
  end

  def self.authenticate(email, password)
    user = User.find_by_email(email)
    if user && user.active? && BCrypt::Engine.hash_secret(password, user.salt) == user.password_digest
      return user
    end
    false
  end

  def create_qrcode
    require 'qiniu'
    require 'rqrcode_png'
    require 'util/qiniu_util'
    return if !email.present?
    return if Rails.env.test?
    email_name = get_email_name email
    qr  = RQRCode::QRCode.new("#{name};#{email}", size: 6, level: :h)
    png = qr.to_img
    png.resize(200, 200).save("public/users/rqrcode/temp_user.png")
    info = QiniuUtil.upload2qiniu!("public/users/rqrcode/temp_user.png", email_name)
  end

  def update_qrcode
    true
  end

  def do_sth_after_commit
    p "do_sth_after_commit"
  end

  protected

  def get_email_name email
    return nil if !email.present?
    email_names = email.to_s.split "@"
    email_name = email_names[0]
  end

  class << self
    def current_user_chart_data
      User.active.where('(NOW() - current_sign_in_at) < ?', 108000)
    end
  end
end
