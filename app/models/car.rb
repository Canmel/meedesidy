class Car < ActiveRecord::Base
  VALID_CAR_NO_REGEX = /^[\u4e00-\u9fa5]{1}[A-Z]{1}[A-Z_0-9]{5}$/
  validates :car_no, presence: true
  validates :car_no, uniqueness: { case_sensitive: false }
  validates :car_no, format: { with: VALID_CAR_NO_REGEX, multiline: true }
  validates :vin, presence: true, length: { maximum: 17, minimum: 17 }
  validates :vin, uniqueness: { case_sensitive: false }
  validates :color, presence: true
  # validates :regist_date, presence: { message: "上牌日期必须填写" }

  enum status: { active: 1, archived: 0 }
  enum operate_type: { free: 0, airport: 1, express: 2, lease: 3, thir: 4, spare: 5 }

  belongs_to :geren
  belongs_to :company
  belongs_to :driver


end
