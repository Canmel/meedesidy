class FlowNode
  attr_accessor :name, :type ,:text

  def initialize(args)
    @type = args[0]
    @text = args[1]
    @name = args[2]
  end

  # 查找下一节点
  def next_node(flow)
    next_node_array = []
    flow.content[:paths].each do |item|
      path = FlowPath.new(content: item)
      if path.from.to_s == self.name.to_s
        next_node_array << path.to
      end
    end
    p "下一节点数组  #{next_node_array}"
    next_node_array.each do |item|
      node = get_node(item, flow.states)
      if node[1][:type] != 'task' || node[1][:type] != 'join'
        next_node(node)
      end
    end

    flow.states.each do |k, v|



    end
  end

  def get_node(rect_name, states)
    states.each do |item|
      return item if item[0].to_s == rect_name
    end
    return nil
  end

  class FlowPath
    attr_accessor :content

    def initialize(args)
      @content = args[:content]
    end

    def to
      content[1][:to]
    end

    def from
      content[1][:from]
    end
  end
end
