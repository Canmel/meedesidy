class CreateCars < ActiveRecord::Migration
  def change
    create_table :cars do |t|
      t.string :car_no, common: "车牌号"
      t.string :vin, common: "车架号"
      t.string :color, common: '颜色'
      t.integer :geren_id, common: '车型'
      t.integer :status, common: '状态'
      t.integer :creater_id, common: '创建者'
      t.integer :updater_id, common: '修改者'

      t.timestamps
    end
  end
end
