class CreateDriver < ActiveRecord::Migration
  def change
    create_table :drivers do |t|
      t.string :name, common: '司机姓名'
      t.string :id_card_no, common: '身份证号'
      t.string :phone, common: '电话号码'
      t.string :entry_time, common: '入职时间'
      t.string :desc, common: '备注'
      t.integer :sex, common: '性别'
      t.integer :status, common: '状态', default: 1
      t.integer :company_id, common: '公司'
      t.integer :updater, common: '修改人'

      t.timestamp
    end
  end
end
