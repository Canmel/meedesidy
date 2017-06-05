class WorkFlowsController < ApplicationController
  load_and_authorize_resource

  def index
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_not] ||= WorkFlow.statuses[:active]
    params[:q][:s] = 'created_at DESC'
    @q = WorkFlow.ransack(params[:q])
    @work_flows= @q.result.page(@page).per(@page_size)
    @work_flows.total_count
  end

  def create
    @work_flow.status = WorkFlow.statuses[:active]
    @work_flow.operater_id = current_user.id
    if @work_flow.save
      flash_msg '创建成功'
      redirect_to :work_flows
    else
      render :new
    end
  end

  def update
    @work_flow.operater_id = current_user.id
    if @work_flow.update(work_flow_params)
      flash_msg '修改成功'
      redirect_to :work_flows
    else
      render :edit
    end
  end

  def publish
    @work_flow.status = WorkFlow.statuses[:publish]
    @work_flow.publish_time = Time.current
    if @work_flow.save
      flash_msg '发布成功'
    else
      flash_msg '发布失败'
    end
    redirect_to :work_flows
  end

  def unpublish
    @work_flow.status = WorkFlow.statuses[:active]
    @work_flow.publish_time = nil
    if @work_flow.save
      flash_msg '撤回成功'
    else
      flash_msg '撤回失败'
    end
    redirect_to :work_flows
  end

  private
  def flash_msg msg
    flash[:work_flow_notice] = msg
  end

  def work_flow_params
    params.require(:work_flow).permit(:name, :flowid, :menu_id, :content, :publish_time, :operater_id, :status, :created_at, :updated_at)
  end
end
