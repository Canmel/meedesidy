class AddStateToFlow < ActiveRecord::Migration
  def change
    add_column :flows, :state, :integer, default: 1
  end
end
