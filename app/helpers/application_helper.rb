module ApplicationHelper
  def all_role
    Role.where(status: Role.statuses[:active])
  end

  def all_menu
    Menu.all
  end

  def load_menus(level, parent_id)
    Menu.find_by_user current_user.id, level, parent_id
  end

  def sequence(index)
    (@page.to_i - 1) * @page_size.to_i + index + 1
  end
end
