class CreateBudgets < ActiveRecord::Migration
  def change
    create_table :budgets do |t|
      t.string :name ,comment: '预算名称'
      t.integer :status, comment: '状态'

      t.timestamps
    end
  end
end
