class CreateFinances < ActiveRecord::Migration
  def change
    create_table :finances do |t|
      t.float :fee, default: 0.0, comment: '收费数量'
      t.integer :car_id, comment: '换电记录'
      t.integer :log_type, comment: '日志类型'
      t.integer :car_id, comment: '车辆'
      t.string :account_num, comment: '对公账户'
      t.string :remark, comment: '备注'
      t.integer :operater, comment: '操作人'

      t.timestamps
    end
  end
end
