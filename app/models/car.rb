class Car < ActiveRecord::Base
  VALID_CAR_NO_REGEX = /^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/
  validates :car_no, presence: true
  validates :car_no, uniqueness: { case_sensitive: false }
  validates :car_no, format: { with: VALID_CAR_NO_REGEX, multiline: true }
  validates :vin, presence: true, length: { maximum: 17, minimum: 17 }
  validates :vin, uniqueness: { case_sensitive: false }
  validates :color, presence: true
  # validates :regist_date, presence: { message: "上牌日期必须填写" }

  enum status: { archived: 0, active: 1, renting: 2 }
  enum operate_type: { free: 0, airport: 1, express: 2, lease: 3, thir: 4, spare: 5 }
  enum change_status: { first_change: 0, normal_change: 1, last_change: 0 }

  belongs_to :geren
  belongs_to :company
  belongs_to :driver
  belongs_to :settlementer, class_name: 'Settlementer' ,foreign_key: 'charge_rule_id', primary_key: 'id'


  attr_accessor :driver_name, :driver_phone

  after_update :update_qrcode
  after_save :create_qrcode

  def valid_driver?
    if driver_id.present?
      return true
    else
      self.errors.add(:driver_name, "司机不能为空")
      self.errors.add(:driver_phone, "手机号不能为空")
      return false
    end
  end

  # 创建二维码
  def create_qrcode
    require 'qiniu'
    require 'rqrcode_png'
    require 'util/qiniu_util'
    return if Rails.env.test?
    qr  = RQRCode::QRCode.new("#{car_no};#{change_status}", size: 6, level: :h)
    png = qr.to_img
    png.resize(200, 200).save("public/cars/rqrcode/temp_car.png")
    info = QiniuUtil.upload2qiniu!("public/cars/rqrcode/temp_car.png", car_no)
  end

  # 更新二维码
  def update_qrcode
    require 'qiniu'
    require 'rqrcode_png'
    require 'util/qiniu_util'
    return if Rails.env.test?
    QiniuUtil.deleteQiniuRqrcode car_no
    qr  = RQRCode::QRCode.new("#{car_no};#{change_status}", size: 6, level: :h)
    png = qr.to_img
    png.resize(200, 200).save("public/cars/rqrcode/temp_car.png")
    info = QiniuUtil.upload2qiniu!("public/cars/rqrcode/temp_car.png", car_no)
  end

# 车辆是否已经绑定
  def binded?
    self.renting? && self.driver_id.present?
  end
# 车辆是否是发车状态（即隶属于某个服务公司）
  def granted?
    self.active? && self.company_id.present?
  end

# 车辆处于入库阶段
  def godowned?
    self.archived? && self.company.nil?
  end
end
