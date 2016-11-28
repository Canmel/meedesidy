class AddStateToRoleAndMenu < ActiveRecord::Migration
  def change
    add_column :roles, :status, :integer, comment: '状态'
    add_column :menus, :status, :integer, comment: '状态'
  end
end
