class CarsController < ApplicationController
  load_and_authorize_resource
  before_action :set_global_search_variable, only: :index

  def index
    @car = Car.new
    @cars = @q.result.page(@page).per(@page_size)
  end

  def create
    @car = Car.new(car_params)
    if @car.save
      flash_msg '创建车辆成功'
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

  private
  def car_params
    params.require(:car).permit(:car_no, :vin, :color, :geren_id)
  end

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] = Car.statuses[:active]
    @q = Car.ransack(params[:q])
  end

  def flash_msg msg
    flash[:car_notice] = msg
  end
end
