class CreateTableMenus < ActiveRecord::Migration
  def change
    create_table(:roles_menus, :id => false) do |t|
      t.references :role
      t.references :menu
    end
  end
end
