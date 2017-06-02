class CreateWorkFlows < ActiveRecord::Migration
  def change
    create_table :work_flows do |t|
      t.string :name, default: '', comment: '工作流名称'
      t.integer :flowid, comment: '流程ID'
      t.string :formtable, default: '', comment: '表单数据存放的表格,存放表单数据'
      t.text :content, comment: '表单，表单设计器保存的xml文件'
      t.datetime :publish_time, comment: '发布时间'
      t.integer :operater_id, comment: '操作人'
      t.integer :status, comment: '状态'

      t.timestamps
    end

    create_table(:work_flow_users, :id => false) do |t|
      t.references :work_flow
      t.references :user
    end
  end
end
