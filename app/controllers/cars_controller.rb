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

# 绑定司机
# 造成数据库影响：
#   1. car 关联　司机driver
#   2. car 状态　为３　租赁中
#  可以绑定
#     1. car　状态为2 激活状态
#     2. car 没有关联　司机
  def bind_driver
    @car = Car.find(params[:id])
    if @car.binded?
      flash_msg "该车辆已经绑定过了"
      redirect_to :cars
    else
      @car.driver_id = car_params[:driver_id]
      @car.status = Car.statuses[:renting]
      if @car.valid_driver? && @car.save
        flash_msg "绑定车辆成功"
        redirect_to :cars
      else
        render :bind
      end
    end
  end

  # 解绑车辆
  # 造成数据库影响：
  # 1. car 解除已关联的司机ID
  # 2. car 状态由３【租赁中】=> ２【激活】
  # 解绑需要
  # 1. car 已经绑定了司机
  # 2. car 状态为３【租赁中】
  def relieve
    # 检查数据！如果不是符合要求的数据不予解绑
    if @car.binded?
      @car.driver = nil
      @car.status = Car.statuses[:active]
      if @car.save
        flash_msg '解绑车辆成功'
      else
        flash_msg '解绑车辆失败'
      end
    else
      flash_msg '车辆未绑定或无司机信息'
    end
    redirect_to :cars
  end

  # 退车
  # 造成数据库影响
  # 1. car 解除已关联的　公司
  # 2. car 状态由２【激活】　=> １【入库】
  # 退车需要
  #   1. car 未绑定司机
  #   2. car 状态为２【激活】
  #   3. 已绑定公司
  def back
    if @car.granted?
      @car.status = Car.statuses[:archived]
      @car.company = nil
      if @car.save
        flash_msg '退车成功'
      else
        flash_msg '退车失败'
      end
    else
      flash_msg '数据不正确或该车辆不是激活状态'
    end
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
