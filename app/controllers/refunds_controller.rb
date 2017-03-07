class RefundsController < ApplicationController
load_and_authorize_resource

  def index
    params[:q] ||= ActionController::Parameters.new
    params[:q][:s] = 'id desc'
    params[:q][:created_at_lteq] = params[:q][:created_at_lteq].to_date.end_of_day if params[:q][:created_at_lteq].present?
    @q = Refund.ransack(params[:q])
    @refunds = @q.result
    @refunds = @refunds.page(@page).per(@page_size)
    @refunds.total_count
  end

  # 同意
  def agree
    if @refund.update(status: Refund.statuses[:active])
      if @refund.active?
        @refund.car.update(:balance => @refund.car.balance - @refund.fee)
        # 产生一条财务记录
        finance = Finance.new(car: @refund.car, fee: @refund.fee, log_type: Finance.log_types[:refund], operater: current_user)
        finance.save
      end
      flash[:notice] = '审批成功'
    else
      flash[:notice] = '审批成功'
    end
    redirect_to :refunds
  end

  # 驳回
  def reject

  end
end
