class ChangeRecordsController < ApplicationController
  load_and_authorize_resource
  before_action :set_global_search_variable, only: :index

  def index
    @records = @q.result.page(@page).per(@page_size)
  end

  def create
    # 先验证 数据信息， 数据信息不正确就不需要在往下了
    if @change_record.valid?
      require 'util/check_out_util'
      car = Car.find_by_car_no(@change_record.car_no)
      # 结算
      result = CheckOutUtil.instance.check_out car, @change_record
      # 获取结算结果并开始组合结算数据
      @change_record.save_check_out_result result
      # 保存换电记录
      if @change_record.save
        flash_msg '录入换电记录成功'
        redirect_to :change_records
      else
        flash_msg '录入换电记录失败'
        render :new
      end
    else
      flash_msg '录入换电记录失败'
      render :new
    end
  end

  def destroy
    if @change_record.update(status: ChangeRecord.statuses[:archived])
      flash_msg '删除换电记录成功'
      save_log(Log.log_types[:record],"#{current_user.name} 删除 #{@change_record.car&.car_no} 的换电记录成功", car_id: @change_record.car_id)
    else
      flash_msg "删除失败"
    end
    p @change_record.errors
    redirect_to :change_records
  end

  private

  def change_record_params
    params.require(:change_record).permit(:car_no, :car_id, :station_id, :drive_distance, :charge_distance, :total_distance, :driver_id, :company_id, :expend_balance, :expend_gift, :cherge_count, :pooled_fee)
  end

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    params[:q][:s] ||= 'id desc'
    params[:q][:status_eq] = ChangeRecord.statuses[:active]
    @q = ChangeRecord.ransack(params[:q])

  end

  def flash_msg msg
    flash[:change_record_notice] = msg
  end

end
