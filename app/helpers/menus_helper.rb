module MenusHelper
  def all_levels
    levels = []
    levels << { k: '1', v: '一级菜单' }
    levels << { k: '2', v: '二级菜单' }
  end

  def parents_menus
    Menu.where( resource_type: 1, status: Menu.statuses[:active] )
  end
end
