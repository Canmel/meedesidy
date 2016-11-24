class CreateMenus < ActiveRecord::Migration
  def change
    create_table(:menus) do |t|
      t.string :name
      t.string :desc
      t.string :source
      t.integer :parent_id
      t.references :resource, :polymorphic => true

      t.timestamps
    end
  end
end
