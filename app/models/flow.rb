class Flow < ActiveRecord::Base
  STATE_TYPE_FORK = 'fork'.freeze
  STATE_TYPE_TASK = 'task'.freeze

  belongs_to :operater, class_name: User
  belongs_to :work_flow
  has_many :tasks

  def start
    content[:states].each do |k, v|
      update_status('开始', k ) if v[:type] == 'start'
    end
    to_next
  end

  # 前往下一节点
  def to_next(node = nil)
    return false if !Task.flow_task_clear?(id)

    next_node.each do |item|
      if item[1][:type] == STATE_TYPE_TASK
        Task.new(flow_id: id, status: Task.statuses[:wait], role_id: item[1][:props][:roles][:value], rect_name: item[0]).save
      end
    end
    if current_fork?
      rect_name = ""
      rect_text = ""
      next_node.each do |item|
        rect_text <<  item[1][:text][:text]
        rect_text << ','
        rect_name << item[0]
        rect_name << ','
      end
      update_status(rect_text, rect_name)
    else
      update_status(next_node[0][1][:text][:text], next_node[0][0])
    end
    reload.current_state.map{|item| item[0]}.each do |type|
      return to_next() if type != STATE_TYPE_TASK
    end

    return true
  end

  def current_rect_name
    current_state.map{|state| state[2]}
  end

  def current_tasks
    Task.where(flow_id: id, status: Task.statuses[:wait]).where('rect_name in (?)', current_rect_name)
  end

  def agree
    current_state
  end

  def current_state_text(type, text)
    content[:states].each do |item|
      return "#{type}&&&#{}" if item[1][type] == 'start' && item[1][:text][:text] = text
    end
  end

  def next_node
    result = []
    content[:paths].each do |item|
      next_node_name = nil
      current_state.each do |state|
        if state[2].to_s == item[1][:from]
          next_node_name = item[1][:to]
        end
      end
      result << [next_node_name, content[:states][next_node_name.to_sym]] if next_node_name.present?
    end
    return result
  end

  def current_state
    current_state_arr = []
    states.each do |item|
      rect_name.split(',').each do |name|
        current_state_arr << item if name == item[2].to_s
      end
    end
    return current_state_arr
  end

  def current_rect
    rect_name
  end

  def content
    eval(work_flow.content)
  end

  def states
    content[:states].map{|k, v| [v[:type], v[:text][:text], k] }
  end

  private

  # 更新状态
  def update_status name, rect_name
    self.status = array_to_str(name)
    self.rect_name = rect_name
    self.save
  end

  # 当前是否是　fork　节点
  def current_fork?
    current_state[0][0] == STATE_TYPE_FORK
  end

  def array_to_str arr
    return arr if !arr.is_a? Array
    return arr.to_s[1,arr.length - 1]
  end
end
