class Settlementer < ActiveRecord::Base
  # 状态： 1 正常， 2 删除
  enum status: { active: 1, archived: 0 }
  # 收费对象： 1 账户余额， 2 对公账户
  enum charger: { balance: 0, account: 1 }
  # 规则名称
  validates :name, presence: true, length: { maximum: 15 }
  # 备注： 最大长度50个字符
  validates :desc, length: { maximum: 50 }
  # 免费里程 |最小收费里程 |最大收费里程 |每公里收费单价
  validates :free_distance, :min_distance, :max_distance, :price, presence: true

  # 结算
  def check_out


  end

end
