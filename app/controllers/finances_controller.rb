class FinancesController < ApplicationController
  load_and_authorize_resource
  before_action :set_global_search_variable, only: :index

  def index
    @finances = @q.result.page(@index).per(@page_size)
  end

  private
  def finance_params
    params.require(:finance).permit(:fee, :car_id, :log_type, :car_id, :account_num, :remark, :created_at)
  end

  def flash_msg msg
    flash[:finance_notice] = msg
  end

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    # params[:q][:status_eq] = Car.statuses[:active]
    @q = Finance.ransack(params[:q])
  end
end
