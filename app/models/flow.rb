class Flow < ActiveRecord::Base
  STATE_TYPE_FORK = 'fork'.freeze
  STATE_TYPE_TASK = 'task'.freeze
  STATE_TYPE_START = 'start'.freeze
  STATE_TYPE_JOIN = 'join'.freeze

  belongs_to :operater, class_name: User
  belongs_to :work_flow
  has_many :tasks

  def start(user)
    states.each do |k, v|
      update(content: content, status: v[:text][:text], rect_name: k )if v[:type].to_s == STATE_TYPE_START
    end
    to_next
  end

  def to_next
    if !Task.flow_task_clear?(self)
      p "还有任务没有完成，不能前往下一步"
      return "还有任务没有完成，不能前往下一步"
    end
    result = get_next
    states.each do |k, v|
      result[1].each do |item|
        if item.to_s == k.to_s
           Task.new(status: Task.statuses[:wait], flow_id: id, role_id: v[:props][:roles][:value], rect_name: k.to_s).save
        end
      end
    end
    update(status: arr_to_str(result[0]), rect_name: arr_to_str(result[1]))
  end

  def get_next(node = nil)
    status_result = []
    rect_name_result = []
    if node.present?
      return next_state(node)
    else
      next_state.each do |item|
        if task?(item) || join?(item)
          item.each{|k, v|
            status_result << v[:text][:text]
            rect_name_result << k.to_s
          }
        else
          result = get_next(item)
          result.each do |item|
            rect_name_result << item.keys[0]
            status_result << item.values[0][:text][:text]
          end
        end
      end
    end
    [status_result, rect_name_result]
  end



  def next_state(node = nil)
    result = []
    if node.present?
      result = result + get_states_by_names(next_rect_names(node.keys[0].to_s))
    else
      current_rect_names.each do |item|
        result = result + get_states_by_names(next_rect_names(item))
      end
    end
    return result.uniq
  end

  def current_state
    result = []
    current_rect_names.each do |item|
      result = result + get_states_by_names([item])
    end
    return result
  end




  private

  def get_states_by_names(names)
    result = []
    states.each do |k, v|
      names.each do |name|
        result << {k => v} if k.to_s == name.to_s
      end
    end
    return result
  end

  def get_name_by_states(node)
    node.each{ |k, v| return k }
  end

  def content
    eval(work_flow.content)
  end

  def states
    content[:states]
  end

  def paths
    content[:paths]
  end

  def props
    content[:props]
  end

  def task?(rect_node)
    rect_node.each{|k, v|  return v[:type] == STATE_TYPE_TASK}
  end

  def join?(rect_node)
    rect_node.each{|k, v|  return v[:type] == STATE_TYPE_JOIN}
  end

  def current_rect_names
    return [] if rect_name.nil?
    rect_name.split(',')
  end

  def next_rect_names(name)
    result = []
    paths.each do |item|
      flow_path = FlowPath.new(content: item)
      if flow_path.from.to_s == name
        result << flow_path.to
      end
    end
    return result
  end

  def arr_to_str arr
    result = ""
    arr.each do |item|
      result << item.to_s
      result << ','
    end
    return result.chop
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