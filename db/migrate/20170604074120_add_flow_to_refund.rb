class AddFlowToRefund < ActiveRecord::Migration
  def change
    add_column :refunds, :flow_id, :integer, comment: '退款发起流程ID'
    add_column :flows, :content, :text
  end
end
