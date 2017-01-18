class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name, common: '公司名称'
      t.string :addr, common: '公司地址'
      t.string :phone, common: '公司电话'
      t.string :contact_name, common: '联系人姓名'
      t.string :contact_phone, common: '联系人电话'
      t.string :sort_name, common: '简称'
      t.integer :status, common: '状态', default: 1

      t.timestamps
    end
  end
end
