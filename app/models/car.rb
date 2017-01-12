class Car < ActiveRecord::Base
  VALID_CAR_NO_REGEX = /^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/
  validates :car_no, presence: { message: "车牌号必须填写" }
  validates :car_no, uniqueness: { case_sensitive: false, message: "车牌号已经存在" }
  validates :car_no, format: { with: VALID_CAR_NO_REGEX, message: "车牌号格式不正确", multiline: true }
  validates :vin, presence: true, length: { maximum: 17, minimum: 17 }
  validates :vin, uniqueness: { case_sensitive: false, message: "车架号已经存在" }
  validates :color, presence: { message: "颜色必须填写" }
  validates :regist_date, presence: { message: "上牌日期必须填写" }

  enum status: { active: 1, archived: 0 }
  belongs_to :genre
end
