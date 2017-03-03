class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :log_type, comment: '日志类型－枚举类型'
      t.integer :operater, comment: '操作人'
      t.integer :status, default: 0, comment: '状态'
      t.integer :car_id, comment: '操作的车辆'
      t.integer :driver_id, comment: '操作的司机'
      t.integer :company_id, comment: '操作的车子或司机所属公司'
      t.string :remark, default: "", comment: '备注信息'

      t.timestamps
    end
  end
end
