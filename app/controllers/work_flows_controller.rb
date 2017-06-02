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
end
