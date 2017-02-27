class Driver < Aasm
  belongs_to :updater, class_name: 'User', foreign_key: 'updater', primary_key: 'id'
  belongs_to :company
  enum sex: { man: 1, woman: 0 }
  enum status: { active: 1, archived: 0 }

  VALID_ID_CARD_NO_REGEX = /([0-9]{17})([0-9]|X)/i
  VALID_PHONE_REGEX      = /1[0-9]{10}/i

  validates :name, :id_card_no, :entry_time, :phone, :desc, :sex ,:company_id, presence: true

  validates :name, uniqueness: true
  validates :id_card_no, length: { maximum: 18, minimum: 18 }, format: { with: VALID_ID_CARD_NO_REGEX }
  validates :phone, format: { with: VALID_PHONE_REGEX, message: '手机号码格式不正确' }, length: { maximum: 11, minimum: 11 }

end
