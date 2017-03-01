class CarsController < ApplicationController
  load_and_authorize_resource
  before_action :set_global_search_variable, only: :index
  autocomplete :driver, :name, :extra_data => [:phone]


  def index
    @car = Car.new
    @cars = @q.result.page(@page).per(@page_size)
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      flash_msg '创建车辆成功'
      save_log(Log.log_types[:basic], current_user, "#{current_user.name} 创建车辆 #{@car.car_no} 成功", car_id: @car.id)
      redirect_to :cars
    else
      flash_msg '创建车辆失败'
      render :new
    end
  end

  def update
    if @car.update(car_params)
      flash_msg '修改车辆成功'
      redirect_to :cars
    else
      flash_msg '修改车辆失败'
      render :edit
    end
  end

  def destroy
    if @car.update(status: 0)
      flash_msg '删除车辆成功'
    else
      flash_msg "删除失败: #{@car.operat_error_msg}"
    end
  end

  # 发车
  # 造成数据库影响：
  # 1. car关联company
  # 2. company状态改为[激活]状态
  # 可以激活
  #   1. status = 0(入库)
  #   2. company.nil? == true
  def grant
    @car = Car.find(params[:id])
    if @car.present? && params[:company_id].present?
      @car.company_id = params[:company_id]
      @car.status = Car.statuses[:active]
      if @car.save
        flash_msg '发车成功'
        save_log(Log.log_types[:grant],
                 nil,
                 "#{current_user.name} 发车 #{@car.car_no} 至 #{@car.company.name} 成功",
                 car_id: @car.id,
                 company_id: @car.company.id)
        render :json => { :code => "200", :result => '发车成功' }
      else
        flash_msg '发车失败'
        render :json => { :code => "500", :result => '发车失败' }
      end
    else
      flash_msg '无法获取车辆信息，发车失败'
      render :json => { :code => '404', :result => '无法获取车辆信息，发车失败'}
    end
  end

  def bind_driver
    redirect_to :cars

  end

  private
  def car_params
    params.require(:car).permit(:car_no, :vin, :color, :geren_id, :company_id, :driver_id, :operater)
  end

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    @q = Car.ransack(params[:q])
  end

  def flash_msg msg
    flash[:car_notice] = msg
  end
end
