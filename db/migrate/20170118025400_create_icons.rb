class CreateIcons < ActiveRecord::Migration
  def change
    create_table :icons do |t|
      t.string :name
      t.string :code
      t.integer :status, default: 1

      t.timestamps null: false
    end
  end
end
