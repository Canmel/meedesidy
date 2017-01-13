class Geren < ActiveRecord::Base
  validates :seat_num, presence: { message: "座位数量必须填写" }, numericality: { only_integer: true, less_than: 10 }
  validates :name, presence: { message: "车型名称必须填写" }, length: { maximum: 10 }

  enum status: { active: 1, archived: 0 }
end
