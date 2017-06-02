class WorkFlow < ActiveRecord::Base
  belongs_to :operater, class_name: "User"

  enum status: { active: 1, archived: 0 }

  def formtable?
    formtable.present?
  end
end
