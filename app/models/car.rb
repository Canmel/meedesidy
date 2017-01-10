class Car < ActiveRecord::Base
  enum status: { active: 1, archived: 0 }
  belongs_to :genre
end
