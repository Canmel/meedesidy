class Icon < ActiveRecord::Base
  has_many :menus

  enum status: { active: 1, archived: 0 }

  validates :name, :code, presence: true
end
