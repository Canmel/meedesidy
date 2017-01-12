class CarsController < ApplicationController
  load_and_authorize_resource
  before_action :set_global_search_variable, only: :index

  def index
    @cars = @q.result.page(@page).per(@pageSize)
  end

  def new
    @car = Car.new
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_car
    @car = Car.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def car_params
    params.require(:cars).permit(:car_no, :vin, :color, :status, :creater, :genre)
  end

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] = Car.statuses[:active]
    @q = Car.ransack(params[:q])
  end
end
