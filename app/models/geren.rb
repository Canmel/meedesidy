class Geren < ActiveRecord::Base
  validates :seat_num, presence: true, numericality: { only_integer: true, less_than: 10 }
  validates :name, presence: true, length: { maximum: 10 }

  enum status: { active: 1, archived: 0 }
  has_one :car
end
