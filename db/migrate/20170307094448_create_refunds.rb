class CreateRefunds < ActiveRecord::Migration
  def change
    create_table :refunds do |t|
      t.float :fee, default: 0.0, comment: '金额'
      t.integer :car_id, comment: '车辆'
      t.integer :operater, comment: '申请人'
      t.integer :remark, comment: '备注'

      t.integer :status, default: 1, comment: '状态'
      t.timestamps
    end
  end
end
