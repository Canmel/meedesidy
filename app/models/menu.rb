class Menu < ActiveRecord::Base
  validates :name, :desc ,presence: true, length: { maximum: 10 }
  validate :source ,:valid_source

  has_and_belongs_to_many :roles, :join_table => :roles_menus
  belongs_to :parent, :class_name => 'Menu', foreign_key: 'parent_id', primary_key: 'id'
  belongs_to :icon

  enum resource_type: { one_level: 1, two_level: 2 }
  enum status: { active: 1, archived: 0 }

  def valid_source
    errors.add(:source, '二级菜单地址不能为空') if two_level? && source.nil?
  end

  class << self
    def find_by_user(user_id, level, parent_id)
      user = User.find(user_id)
      roles = user.roles
      menus = []
      roles.each do |role|
        if Menu.resource_types[level] == Menu.resource_types[:one_level]
          role_menus = role.menus.where(resource_type: Menu.resource_types[level])
        else
          role_menus = role.menus.where(resource_type: Menu.resource_types[level], parent_id: parent_id)
        end
        role_menus.each do |menu|
            menus << menu
        end
      end
      menus.uniq
    end
  end
end
