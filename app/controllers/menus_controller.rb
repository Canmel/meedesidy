class MenusController < ApplicationController
  before_action :set_menu, only: [:show, :edit, :update, :destroy]

  def index
    @q = Menu.ransack(params[:q])
    @menus = @q.result(distinct: true)
  end

  def new
    @menu = Menu.new
  end

  def create
    @menu = Menu.new(menu_params)
    @menu.parent_id=nil unless @menu.resource_type == 1
    @menu.save
    redirect_to :menus
  end

  def edit
  end

  def update
    if @menu.update(menu_params)
      flash[:notice] = "编辑成功"
      redirect_to :menus
    else
      flash[:notice] = "编辑失败"
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_menu
    @menu = Menu.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def menu_params
    params.require(:menu).permit(:name, :id, :desc, :parent_id, :source, :resource_type)
  end
end
