class Task < ActiveRecord::Base
  enum status: { wait: 0, agree: 1, reject: 2 }

  validates :role_id, presence: true
  validate :valid_user_roles, on: [:to_pass, :to_reject]

  belongs_to :flow

  def to_pass(user, remark=nil)
    self.status = Task.statuses[:agree]
    self.operater_id = user.id
    self.remark = remark
    self.save
  end

  def to_reject(user, remark=nil)
    self.status = Task.statuses[:reject]
    self.operater_id = user.id
    self.remark = remark
    self.save
  end

  def valid_user_roles
    errors.add(:operater_id, '用户没有权限操作') unless User.find(operater_id).roles.pluck(:id).include? role_id
  end

  class << self
    # 判断一个流程当前任务是否都已经完成
    def flow_task_clear?(flow)
      Task.where(flow_id: flow.id, status: Task.statuses[:wait]).where('rect_name in (?)', flow.rect_name.split(',')).size.zero?
    end

    def user_tasks(flow, user)
      Task.where(flow_id: flow.id, status: Task.statuses[:wait]).where('rect_name in (?)', flow.rect_name).where('role_id in (?)', user.roles.map(&:id))
    end
  end
end
