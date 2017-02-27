class UserObserve < ActiveRecord::Observer
  observe :user


  # save 之后触发
  # 自带事务
  # 失败会连带save方法回滚
  def after_save(user)
    true
  end

end