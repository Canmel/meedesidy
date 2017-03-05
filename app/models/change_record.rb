class ChangeRecord < ActiveRecord::Base
  belongs_to :company
  belongs_to :driver
  belongs_to :car

  enum status: { active: 1, archived: 0 }

  validates :total_distance, :drive_distance, presence: true
  validate :car_info_valid, on: :create

  attr_accessor :car_no

  after_create :change_car_info

  def save_check_out_result result
    car = Car.find_by_car_no car_no
    # 保存换电记录的车辆，公司，司机信息
    self.car_id = car.id
    self.company_id = car.company&.id
    self.driver_id = car.driver&.id
    # 保存换电记录的单次行驶里程
    self.drive_distance = self.total_distance - car.distance
    self.expend_balance = result[:expend_balance]
    self.expend_gift = result[:expend_gift]
    self.expend_count = result[:expend_count]
  end


  # 换电之后执行
  # 修改车辆信息
  # 1. 车辆换电状态如果是首次换电 => 普通换电
  # 2. 修改车辆行驶里程
  def change_car_info
    car = Car.find_by_car_no car_no
    car.distance = self.total_distance
    car.change_status = Car.change_statuses[:normal_change]
    car.save
  end

  private

  # 车辆验证
  # 1. 车牌号不为空
  # 2. 车牌号必须存在
  # 3. 车辆是否绑定
  def car_info_valid
    return errors.add(:car_no, '车牌号不能为空') if car_no.nil?
    return errors.add(:car_no, '请输入正确的车牌号信息') if !Car.exists?(:car_no => car_no)
    car = Car.find_by_car_no(car_no)
    return errors.add(:car_no, '该车未绑定，请先绑定后再换电') if !car.binded?
  end

  # 验证换电信息
  # 1. 是不是一般换电
  # 2. 一般换电是要收费的
  # 3. 判断余额或者礼物能不能支付
  # 4. 不能支付要提示并且不能换电
  def change_info_valid
    car = Car.find_by_car_no(car_no)
    if car.normal_change?
      # 不是第一次换电，或者最后一次换电
      # 去判断余额够不够
      # 余额不够不给换电，提示
    end

  end
end
