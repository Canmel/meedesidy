module RolesHelper
  def all_menu
    Menu.where(status: Menu.statuses[:active])
  end
end
