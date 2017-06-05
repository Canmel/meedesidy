class WorkFlow < ActiveRecord::Base
  belongs_to :operater, class_name: :User
  belongs_to :menu
  enum status: { active: 1, archived: 0, publish: 2 }

  def formtable?
    formtable.present?
  end
end
