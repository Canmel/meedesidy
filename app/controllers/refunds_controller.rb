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
    ActiveRecord::Base.transaction do
    if @refund.update!(status: Refund.statuses[:active])
      if @refund.active?
        # @refund.car.update!(:balance => @refund.car.balance - @refund.fee)
        # 产生一条财务记录
        finance = Finance.new(account_type: 0, car_no: @refund.car.car_no, car_id: @refund.car.id, fee: @refund.fee, log_type: Finance.log_types[:refund], operater: current_user)
        finance.save!
        flash_msg '审批成功'
      end
    else
      flash_msg '审批失败'
    end
    redirect_to :refunds
    end
  end

  # 驳回
  def reject
    ActiveRecord::Base.transaction do
      p @refund
      if refund_params[:remark].nil?
        flash_msg '备注不能为空'
        return redirect_to :refunds
      end
      if @refund.update!(status: Refund.statuses[:archived], remark: refund_params[:remark])
        flash_msg '审批成功'
      else
        flash_msg '审批失败'
      end
      redirect_to :refunds
    end
  end

  private
  def refund_params
    params.require(:refund).permit(:remark, :fee, :car_id, :operater, :status)
  end

  def flash_msg msg
    flash[:refund_notice] = msg
  end
end
