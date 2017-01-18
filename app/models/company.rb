class Company < ActiveRecord::Base
  belongs_to :driver

  VALID_PHONE_REGEX      = /1[0-9]{10}/i
  validates :addr, :name, :contact_name, :contact_phone, :phone, :sort_name, presence: true
  validates :phone, :contact_phone, format: { with: VALID_PHONE_REGEX }, length: { maximum: 11, minimum: 11 }

  enum status: { active: 1, archived: 0 }
end
