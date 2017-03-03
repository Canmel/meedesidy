class LogsController < ApplicationController
  load_and_authorize_resource
  before_action :set_logs, only: [:show, :edit, :update, :destroy]

  def index
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] ||= Log.statuses[:active]
    params[:q][:s] = 'id desc'
    @q = Log.ransack(params[:q])
    @logs = @q.result
    @logs = @logs.page(@page).per(@page_size)
    @logs.total_count
  end

  def create
    @logs.save
  end

  private

  def set_logs
    @log = Log.find(params[:id])
  end

  def log_params
    params.require(:log).permit(:type, :operater, :status, :car_id, :driver_id, :company_id, :remark, :created_at, :updated_at)
  end

end
