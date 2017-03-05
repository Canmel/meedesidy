class CheckOutUtil
  @@instance = CheckOutUtil.new

  def self.instance
    @@instance
  end

  def check_out car, record
    if car.normal_change?
      return { total_distance: record.total_distance,
               drive_distance: record.total_distance - car.distance,
               charge_distance: 0,
               expend_gift: 0,
               expend_balance: 0,
               expend_count: 0,
               change_count: 0,
               pooled_fee: 0 }
    else
      return { total_distance: record.total_distance,
               drive_distance: record.total_distance - car.distance,
               charge_distance: 0,
               expend_gift: 0,
               expend_balance: 0,
               expend_count: 0,
               change_count: 0,
               pooled_fee: 0 }

    end



  end

  private_class_method :new
end