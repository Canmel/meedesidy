class AddDescToRole < ActiveRecord::Migration
  def change
    add_column :roles, :desc, :string, comment: '描述信息'
    add_column :roles, :level, :integer, comment: '菜单等级'
  end
end
