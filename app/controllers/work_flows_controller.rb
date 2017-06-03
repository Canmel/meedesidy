class WorkFlowsController < ApplicationController
  load_and_authorize_resource

  def index
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] ||= WorkFlow.statuses[:active]
    params[:q][:s] = 'created_at DESC'
    @q = WorkFlow.ransack(params[:q])
    @work_flows= @q.result.page(@page).per(@page_size)
    @work_flows.total_count
  end

  def create
    @work_flow.status = WorkFlow.statuses[:active]
    @work_flow.operater_id = current_user.id
    if @work_flow.save
      redirect_to :work_flows
    else
      render :new
    end
  end

  def update
    @work_flow.operater_id = current_user.id
    if @work_flow.update(work_flow_params)
      redirect_to :work_flows
    else
      render :edit
    end
  end

  private

  def work_flow_params
    params.require(:work_flow).permit(:name, :flowid, :formtable, :content, :publish_time, :operater_id, :status, :created_at, :updated_at)
  end
end
