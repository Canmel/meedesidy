class CreateFlows < ActiveRecord::Migration
  def change
    create_table :flows do |t|
      t.string :name, default: '', comment: '名称'
      t.integer :menu_id
      t.text :formtable
      t.integer :work_flow_id, comment: '流程'
      t.integer :operater_id, comment: '操作人'
      t.string :status, comment: '状态'

      t.timestamps
    end

  end
end
