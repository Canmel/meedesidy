class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  def index
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] = 1
    @q = Role.ransack(params[:q])
    @roles = @q.result.page(@page).per(@pageSize)
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    @role.status = Role.statuses[:active]
    if @role.save
      flash_msg '创建成功'
      redirect_to :roles
    else
      flash_msg '创建失败'
      render :new
    end
  end

  def destroy
    if @role.name != 'admin'
      if @role.update_attributes(status: 0)
        flash_msg '删除成功'
      else
        flash_msg "删除失败: #{@role.operat_error_msg}"
      end
      redirect_to :roles
    else
      flash_msg 'admin角色不能删除'
      redirect_to :roles
    end
  end

  def update
    if @role.update(role_params)
      flash_msg "编辑成功"
      redirect_to :roles
    else
      render :edit
    end
  end


  private
  # Use callbacks to share common setup or constraints between actions.
  def set_role
    @role = Role.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def role_params
    params.require(:role).permit(:name, :id, :desc, :level, :menu_ids => [])
  end

  def flash_msg msg
    flash[:role_notice] = msg
  end
end
