class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :flow_id, comment: '流程id'
      t.integer :status, default: 0, comment: '任务状态（审核）'
      t.string :remark, default: '', comment: '备注'
      t.integer :operater_id, comment: '操作人'
      t.integer :role_id
      t.string :rect_name

      t.timestamps
    end
  end
end
