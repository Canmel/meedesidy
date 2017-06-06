class AddRectNameToFlow < ActiveRecord::Migration
  def change
    add_column :flows, :rect_name, :string, comment: 'rectname'
  end
end
