class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] = 1
    @q = Menu.ransack(params[:q])
    @menus = @q.result.page(@page).per(@page_size)
    @menus.total_count
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.status = 1
    @menu.parent_id=nil unless @menu.resource_type == Menu.resource_types[:one_level]
    if @menu.save
      flash_msg '创建成功'
      save_log(Log.log_types[:sys], current_user, "#{current_user.name} 创建菜单 #{@menu.name} 成功！")
      redirect_to :menus
    else
      flash_msg '创建失败'
      render :edit
    end
  end

  def update
    if @menu.update(menu_params)
      flash_msg "编辑成功"
      save_log(Log.log_types[:sys], current_user, "#{current_user.name} 修改菜单 #{@menu.name} 成功！")
      redirect_to :menus
    else
      flash_msg "编辑失败"
      render :edit
    end
  end

  def destroy
    if @menu.update_attributes(status: 0)
      save_log(Log.log_types[:sys], current_user, "#{current_user.name} 删除菜单 #{@menu.name} 成功！")
      flash_msg '删除成功'
    else
      flash_msg '删除失败'
    end
    redirect_to :menus
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_menu
    @menu = Menu.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def menu_params
    params.require(:menu).permit(:name, :id, :desc, :parent_id, :source, :resource_type, :icon_id)
  end

  def flash_msg msg
    flash[:menu_notice] = msg
  end
end
