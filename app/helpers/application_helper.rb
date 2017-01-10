module ApplicationHelper
  def all_role
    Role.all
  end

  def all_menu
    Menu.all
  end

  def load_menus(level, parent_id)
    Menu.find_by_user current_user.id, level, parent_id
  end
end
