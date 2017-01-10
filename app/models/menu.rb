class Menu < ActiveRecord::Base
  has_and_belongs_to_many :roles, :join_table => :roles_menus
  enum status: { active: 1, archived: 0 }
  enum resource_type: { one: 1, two: 2 }

  def one_level_menu?
    status == Menu.resource_types[:one]
  end

  def two_level_menu?
    status == Menu.resource_types[:two]
  end

  class << self
    def find_by_user(user_id, level, parent_id)
      user = User.find(user_id)
      roles = user.roles
      menus = []
      roles.each do |role|
        role_menus = role.menus
        role_menus.each do |menu|
          p menu.name
          p menu.resource_type
          p level == menu.resource_type.to_i
          if level == menu.resource_type.to_i
            if parent_id == menu.parent_id.to_i
              menus << menu
            end
          end
          p menus
        end
      end
      menus = menus.uniq
    end
  end
end
