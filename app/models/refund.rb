class Refund < ActiveRecord::Base
  belongs_to :car
  belongs_to :operater, class_name: 'User', primary_key: 'id', foreign_key: 'operater'
  belongs_to :flow

  enum status: { archived: 0, apply: 1, active: 2 }

  def examine?(user)
    result = flow&.tasks
    return false if result.nil?
    result.each do |task|
      return true if (user.roles.map(&:id).include? task.role&.id)
    end
    false
  end
end
