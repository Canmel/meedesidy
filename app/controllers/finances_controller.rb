class FinancesController < ApplicationController
  load_and_authorize_resource
  before_action :set_global_search_variable, only: :index

  def index
    @finances = @q.result.page(@index).per(@page_size)
  end

  # 创建　=> 充值
  # 条件　=> 车牌号存在，已绑定
  # 对数据库影响
  # 1. 创建一条充值记录
  # 2. 相应的充值，添加相应的数目
  def create
    p @finance
    if @finance.valid?
      if finance_params[:account_type] == 1
        flash_msg '暂时不支持对公账户充值'
        return redirect_to :finances
      else
        car = Car.find_by_car_no @finance.car_no
        @finance.car_id = car&.id
        @finance.log_type = Finance.log_types[:recharge]
        if @finance.save
          flash_msg '充值成功'
          redirect_to :finances
        else
          flash_msg '充值失败'
          render :new
        end
      end
      # @finance.
    else
      render :new
      return
    end
  end

  private
  def finance_params
    params.require(:finance).permit(:fee, :car_id, :log_type, :car_id, :account_num, :remark, :created_at, :account_type, :car_no)
  end

  def flash_msg msg
    flash[:finance_notice] = msg
  end

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    # params[:q][:status_eq] = Car.statuses[:active]
    params[:q][:s] = 'id desc'
    params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day if params[:q][:created_at_lteq].present?
    @q = Finance.ransack(params[:q])
  end
end
