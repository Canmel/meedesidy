class CreateChangeRecords < ActiveRecord::Migration
  def change
    create_table :change_records do |t|
      t.integer :station_id, comment: '换电站ID'
      t.integer :drive_distance, default: 0, comment: '本次行驶里程'
      t.integer :charge_distance, default: 0, comment: '收费里程'
      t.integer :total_distance, default: 0, comment: '车辆行驶总里程'
      t.integer :company_id, comment: '公司'
      t.integer :driver, comment: '司机'
      t.integer :car, comment: '车辆'
      t.integer :change_count, default: 1, comment: '当日换电次数'
      t.float :expend_balance, default: 0.0, comment: '消耗余额数量'
      t.float :expend_gift, default: 0.0, comment: '消耗余额礼物数量'
      t.float :expend_count, default: 0.0, comment: '总消费'

      t.timestamps
    end
  end
end
