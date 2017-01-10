class AddResouceTypeToMenus < ActiveRecord::Migration
  def change
    add_column :menus, :resource_type, :integer, comment: '菜单等级'
  end
end
