class Role < ActiveRecord::Base
  has_and_belongs_to_many :users, :join_table => :users_roles
  has_and_belongs_to_many :menus, :join_table => :roles_menus
  enum status: { active: 1, archived: 0 }

  belongs_to :resource,
             :polymorphic => true
             # :optional => true

  validates :resource_type,
            :inclusion => { :in => Rolify.resource_types },
            :allow_nil => true
  validates :name, presence: true, length: { maximum: 20 }
  validates :desc, presence: true, length: { maximum: 20 }, allow_blank: true
  validate :valid_menu_size

  def valid_menu_size
    if menus.size.zero?
      errors.add(:menu_ids, '菜单不能为空')
    end
  end

  def operat_error_msg
    error_msg = ""
    errors&.messages.each do |msg|
      error_msg = "#{error_msg} #{msg.last.first}"
    end
    error_msg << " 请联系管理员"
  end

  scopify
end
