class IconsController < ApplicationController
  before_action :set_icon, only: [:update, :destroy, :edit]

  def index
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] = 1
    @q = Icon.ransack(params[:q])
    @icons = @q.result.page(@page).per(@page_size)
    @icons.total_count
  end

  def new
    @icon = Icon.new
  end

  def create
    @icon = Icon.new(icon_params)
    if @icon.save
      flash_msg '创建图标成功'
      redirect_to :icons
    else
      render :new
    end
  end

  def update
    if @icon.update(icon_params)
      flash_msg '修改图标成功'
      redirect_to :icons
    else
      render :edit
    end
  end

  def destroy
    if @icon.update(status: Icon.statuses[:archived])
      flash_msg '删除成功'
    else
      flash_msg '删除失败'
    end
    redirect_to :icons
  end

  private
  def flash_msg msg
    flash[:icons_notice] = msg
  end

  def set_icon
    @icon = Icon.find(params[:id])
  end

  def icon_params
    params.require(:icon).permit(:name, :id, :code, :status)
  end

end
