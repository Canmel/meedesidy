require 'rails_helper'

RSpec.describe Flow, type: :model do
  let!(:user) { create :user_admin }
  it 'test' do
    work_flow = WorkFlow.new(content: "{states:{rect20:{type:'start',text:{text:'开始'}, attr:{ x:409, y:10, width:50, height:50}, props:{text:{value:'开始'},temp1:{value:''},temp2:{value:''}}},rect21:{type:'task',text:{text:'任务1'}, attr:{ x:386, y:116, width:100, height:50}, props:{text:{value:'任务1'},temp1:{value:''},roles:{value:'3'},assignee:{value:''},form:{value:'2222'},desc:{value:''}}},rect22:{type:'fork',text:{text:'分支'}, attr:{ x:410, y:209, width:50, height:50}, props:{text:{value:'分支'},temp1:{value:''},temp2:{value:''}}},rect23:{type:'task',text:{text:'任务2'}, attr:{ x:192, y:317, width:100, height:50}, props:{text:{value:'任务2'},temp1:{value:''},roles:{value:'3'},assignee:{value:''},form:{value:''},desc:{value:''}}},rect24:{type:'task',text:{text:'任务3'}, attr:{ x:385, y:317, width:100, height:50}, props:{text:{value:'任务3'},temp1:{value:''},roles:{value:'3'},assignee:{value:''},form:{value:''},desc:{value:''}}},rect25:{type:'task',text:{text:'任务4'}, attr:{ x:556, y:320, width:100, height:50}, props:{text:{value:'任务4'},temp1:{value:''},roles:{value:'3'},assignee:{value:''},form:{value:''},desc:{value:''}}},rect26:{type:'join',text:{text:'合并'}, attr:{ x:410, y:416, width:50, height:50}, props:{text:{value:'合并'},temp1:{value:''},temp2:{value:''}}},rect27:{type:'end',text:{text:'结束'}, attr:{ x:409, y:633, width:50, height:50}, props:{text:{value:'结束'},temp1:{value:''},temp2:{value:''}}},rect28:{type:'task',text:{text:'任务5'}, attr:{ x:384, y:528, width:100, height:50}, props:{text:{value:'任务5'},temp1:{value:''},roles:{value:''},assignee:{value:''},form:{value:''},desc:{value:''}}}},paths:{path29:{from:'rect20',to:'rect21', dots:[],text:{text:'TO 任务1'},textPos:{x:37,y:-4}, props:{text:{value:''}}},path30:{from:'rect21',to:'rect22', dots:[],text:{text:'TO 分支'},textPos:{x:56,y:-1}, props:{text:{value:''}}},path31:{from:'rect22',to:'rect24', dots:[],text:{text:'TO 任务3'},textPos:{x:24,y:-5}, props:{text:{value:''}}},path32:{from:'rect24',to:'rect26', dots:[],text:{text:'TO 合并'},textPos:{x:41,y:8}, props:{text:{value:''}}},path33:{from:'rect26',to:'rect28', dots:[],text:{text:'TO 任务5'},textPos:{x:36,y:-5}, props:{text:{value:''}}},path34:{from:'rect28',to:'rect27', dots:[],text:{text:'TO 结束'},textPos:{x:32,y:0}, props:{text:{value:''}}},path35:{from:'rect22',to:'rect23', dots:[{x:244,y:232}],text:{text:'TO 任务2'},textPos:{x:0,y:-10}, props:{text:{value:'TO 任务2'}}},path36:{from:'rect23',to:'rect26', dots:[{x:242,y:435}],text:{text:'TO 合并'},textPos:{x:-3,y:17}, props:{text:{value:'TO 合并'}}},path37:{from:'rect22',to:'rect25', dots:[{x:607,y:234}],text:{text:'TO 任务4'},textPos:{x:0,y:-10}, props:{text:{value:'TO 任务4'}}},path38:{from:'rect25',to:'rect26', dots:[{x:607,y:439}],text:{text:'TO 合并'},textPos:{x:-8,y:16}, props:{text:{value:'TO 合并'}}}},props:{props:{name:{value:'新建流程'},key:{value:''},desc:{value:''}}}}" )
    work_flow.save
    flow  = Flow.new({work_flow: work_flow, operater: user, formtable: "", name: "买包烟申请"})
    flow.content = work_flow.content
    flow.save
    flow.reload
    p "开始一个流程"
    flow.start(user)
    flow.reload.to_next
    tasks =  Task.where(flow_id: flow.id, status: Task.statuses[:wait]).where('rect_name in (?)', flow.rect_name)
    tasks.each do |task|
      task.to_pass(user, '同意')
    end
    flow.reload.to_next
    flow.reload.to_next
    tasks =  Task.where(flow_id: flow.id, status: Task.statuses[:wait]).where('rect_name in (?)', flow.rect_name.split(','))
    tasks.each do |task|
      task.to_pass(user, '同意')
    end
    flow.reload.to_next
    flow.reload.to_next
    tasks =  Task.where(flow_id: flow.id, status: Task.statuses[:wait]).where('rect_name in (?)', flow.rect_name.split(','))
    tasks.each do |task|
      task.to_pass(user, '同意')
    end
    flow.reload.to_next
    expect(flow.reload.state_i18n).to eq '销毁'
  end

end
