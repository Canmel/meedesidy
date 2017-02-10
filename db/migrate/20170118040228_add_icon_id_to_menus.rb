class AddIconIdToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :icon_id, :integer, comment: '菜单图标'
  end
end
