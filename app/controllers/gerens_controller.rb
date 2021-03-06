class GerensController < ApplicationController
  load_and_authorize_resource

  def index
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] ||= Geren.statuses[:active]
    params[:q][:s] = 'id desc'
    @q = Geren.ransack(params[:q])
    @gerens = @q.result.page(@page).per(@page_size)
    @gerens.total_count
  end

  def new
    @geren = Geren.new
  end

  def create
    @geren = Geren.new(geren_params)
    if @geren.save
      flash_msg '新建车型成功'
      redirect_to :gerens
    else
      flash_msg '新建车型失败'
      render :new
    end
  end

  def update
    if @geren.update(geren_params)
      flash_msg '修改车型成功'
      redirect_to :gerens
    else
      flash_msg '修改车型失败'
      render :edit
    end
  end

  private
  def flash_msg msg
    flash[:gerens_notice] = msg
  end

  def geren_params
    params.require(:geren).permit(:name, :seat_num, :id)
  end
end
