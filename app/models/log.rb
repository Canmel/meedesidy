class Log < ActiveRecord::Base
  enum status: { active: 1, archived: 0 }
  # sys: 系统级别 －－｜用户｜角色｜菜单｜图标｜的增删改查
  # grant: 发车记录　
  # basic: 基础参数
  # back: 退车
  # bind: 绑定
  # relieve: 解绑
  # record
  enum log_type: { sys: 1, grant: 2, basic: 3, back: 4, bind: 5, relieve: 6, record: 7 }

  belongs_to :operater, class_name: 'User' ,foreign_key: 'operater', primary_key: 'id'
  belongs_to :company
  belongs_to :driver
  belongs_to :car
end
