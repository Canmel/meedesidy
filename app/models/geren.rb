class Geren < ActiveRecord::Base
  validates :seat_num, presence: { message: "座位数量必须填写" }
  validates :name, presence: { message: "车型名称必须填写" }

  enum status: { active: 1, archived: 0 }
end
