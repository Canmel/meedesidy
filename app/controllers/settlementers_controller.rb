class SettlementersController < ApplicationController
  load_and_authorize_resource
  before_action :set_global_search_variable, only: [:index]

  def index
    @settlementers = @q.result.page(@page).per(@page_size)
  end

  def create
    @settlementer = Settlementer.new(settlementer_params)
    @settlementer.charger = Settlementer.chargers[:account] if @settlementer.account_num.present?
    if @settlementer.save
      flash_msg '创建收费规则成功'
      save_log Log.log_types[:basic], "#{current_user.name} 创建收费规则 #{@settlementer.name} 成功"
      redirect_to :settlementers
    else
      flash_msg '创建收费规则失败'
      render :new
    end
  end

  def update
    @settlementer.charger = Settlementer.charger[:account] if @settlementer.account_num.present?
    if @settlementer.update(settlementer_params)
      flash_msg '修改收费规则成功'
      save_log Log.log_types[:basic], "#{current_user.name} 修改收费规则 #{@settlementer.name} 成功"
      redirect_to :settlementers
    else
      flash_msg '修改收费规则失败'
      render :edit
    end
  end

  private

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status] ||= Settlementer.statuses[:active]
    @q = Settlementer.ransack(params[:q])
  end

  def settlementer_params
    params.require(:settlementer).permit(:name, :id, :desc, :free_distance, :min_distance, :max_distance, :price, :charger, :account_num)
  end

  def flash_msg msg
    flash[:settlementer_notice] = msg
  end
end
