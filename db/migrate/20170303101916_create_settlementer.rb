class CreateSettlementer < ActiveRecord::Migration
  def change
    create_table :settlementers do |t|
      t.string :name, comment: '规则名称'
      t.string :desc, comment: '描述'
      t.integer :free_distance, default: 0, comment: '免费里程'
      t.integer :min_distance, default: 0, comment: '最小收费里程'
      t.integer :max_distance, default: 0, comment: '最大收费里程'
      t.float :price, default: 0.0, comment: '单价'
      t.integer :charger, default: 0, comment: '收费对象，枚举类型'
      t.string :account_num, comment: '对公账号'
    end
  end
end
