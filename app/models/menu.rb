class Menu < ActiveRecord::Base
  has_and_belongs_to_many :roles, :join_table => :roles_menus
  belongs_to :parent, :class_name => 'Menu', foreign_key: 'parent_id', primary_key: 'id'

  enum resource_type: { one_level: 1, two_level: 2 }
  enum status: { active: 1, archived: 0 }

  class << self
    def find_by_user(user_id, level, parent_id)
      user = User.find(user_id)
      roles = user.roles
      menus = []
      roles.each do |role|
        role_menus = role.menus
        role_menus.each do |menu|
          if level == menu.resource_type
            p menu.parent.nil?
            if parent_id == menu.parent&.id
              menus << menu
            end
          end
        end
      end
      p menus
      menus.uniq
    end
  end
end
