class CreateCarGerens < ActiveRecord::Migration
  def change
    create_table :gerens do |t|
      t.string :name, common: "车型名称"
      t.integer :seat_num, common: "座位数"
      t.integer :status, defaul: 1, common: "状态"

      t.timestamps
    end
  end
end
