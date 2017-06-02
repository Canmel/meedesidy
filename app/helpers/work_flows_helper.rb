module WorkFlowsHelper
  def formtable_show(flow)
    flow.formtable? ? "有" : "无"
  end

end
