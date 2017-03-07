class Refund < ActiveRecord::Base
  belongs_to :car
  belongs_to :operater, class_name: 'User', primary_key: 'id', foreign_key: 'operater'

  enum status: { archived: 0, apply: 1, active: 2 }

end
