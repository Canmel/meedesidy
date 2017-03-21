class AddResouceTypeToMenus < ActiveRecord::Migration
  def change
    change_column :menus, :resource_type, :integer
  end
end
