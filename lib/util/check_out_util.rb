class CheckOutUtil
  @@instance = CheckOutUtil.new

  def self.instance
    @@instance
  end

  # 结算
  # car [Car] 车辆信息｜　必须绑定过的
  # record [ChangeRecord] 换电记录
  # return 结算数据，　没有真正扣费
  def check_out car, record
    if car.normal_change?
      settlementer = car.settlementer
      # distance | 本次换电需要计算的里程
      distance = record.total_distance - car.distance
      # free_distance 免费里程| 默认为0 |直接判断大小 | 优先结算
      distance = distance - settlementer.free_distance if settlementer.free_distance > 0
      # min_distance 默认0 | 小于收费最小里程， 取最小里程
      distance = settlementer.min_distance if settlementer.min_distance > 0 && distance <= settlementer.min_distance
      # max_distance 默认0 | 大于收费最大里程， 取最大里程
      distance = settlementer.max_distance if settlementer.max_distance > 0 && distance >= settlementer.max_distance

      charge_fee = distance * settlementer.price
      # 对个人收费 | 默认为０
      expend_balance = charge_fee if settlementer.balance?
      expend_balance ||= 0
      # 对公收费｜　默认为　０
      pooled_fee = charge_fee if settlementer.account?
      pooled_fee ||= 0
      # 返回结算数据
      return { total_distance: record.total_distance,
               drive_distance: record.total_distance - car.distance,
               charge_distance: distance,
               expend_gift: 0,
               expend_balance: expend_balance,
               expend_count: charge_fee,
               change_count: expend_balance,
               pooled_fee: pooled_fee }
    else
      # 只有normal_change?的时候才会按规则结算
      return { total_distance: record.total_distance,
               drive_distance: record.total_distance - car.distance,
               charge_distance: 0,
               expend_gift: 0,
               expend_balance: 0,
               expend_count: 0,
               change_count: 0,
               pooled_fee: 0 }

    end


    # 通过收费规则，获取最终收费的里程
    # car 【Car】车辆信息
    # record [ChangeRecord] 换电记录
    def check_distance_by_settlement car, record
      distance = 0
      # distance | 本次换电需要计算的里程
      distance = record.total_distance - car.distance
      # free_distance 免费里程| 默认为0 |直接判断大小 | 优先结算
      distance = distance - settlementer.free_distance if settlementer.free_distance > 0
      # min_distance 默认0 | 小于收费最小里程， 取最小里程
      distance = record.min_distance if record.min_distance > 0 && distance <= record.min_distance
      # max_distance 默认0 | 大于收费最大里程， 取最大里程
      distance = record.max_distance if record.max_distance > 0 && distance >= record.max_distance
    end



  end

  private_class_method :new
end