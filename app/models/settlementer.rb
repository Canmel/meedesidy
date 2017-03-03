class Settlementer < ActiveRecord::Base
  # 状态： 1 正常， 2 删除
  enum status: { active: 1, archived: 0 }
  # 收费对象： 1 账户余额， 2 对公账户
  enum charger: { balance: 1, account: 0 }

end
