class Company < ActiveRecord::Base
  belongs_to :driver

  enum status: { active: 1, archived: 0 }
end
