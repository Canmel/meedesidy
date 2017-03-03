class AddColumsToCars < ActiveRecord::Migration
  def change
    add_column :cars, :distance, :integer, default: 0, comment: '车辆行驶里程'
    add_column :cars, :balance, :double, default: 0.0, comment: '车辆中剩余的余额'
    add_column :cars, :charge_rule_id, :integer, comment: '换电收费规则id'
    add_column :cars, :change_status, :integer, default: 0, comment: '车辆换电状态，枚举类型'

    add_column :drivers, :id_card, :string, default: '', comment: '司机身份证号'
  end
end
