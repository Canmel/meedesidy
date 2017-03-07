class Finance < ActiveRecord::Base
  enum log_type: { recharge: 1, refund: 2 }

  belongs_to :car
  belongs_to :operater, class_name: 'User', primary_key: 'id', foreign_key: 'operater'

  # 创建充值记录后更新余额
  after_create :update_fee

  # 验证账户
  # 1. 车辆是否存在
  # 2. 车牌号不能为空
  # 3. 车辆需要已绑定
  validate :valid_account
  attr_accessor :car_no, :account_type

  def valid_account
    if !pooled_account?
      return errors.add(:car_no, "个人账户车牌号不能为空") if !car_no.present?
      car = Car.find_by_car_no car_no
      return errors.add(:car_no, "车辆不存在") if car.nil?
      return errors.add(:car_no, "车辆未绑定") if !car.binded?
    end
  end

  # 是否是对公账户
  def pooled_account?
    account_type.to_i == 1
  end

  # 更新余额
  def update_fee
    if self.car.present? && self.fee > 0
      # 充值
      if self.recharge?
        balance = car.balance + self.fee
        car.update(balance: balance)
      # 退款
      elsif self.refund?
        balance = car.balance - fee
        car.update(balance: balance)
      end
    end
  end
end
