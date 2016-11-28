class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  def index
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] = 1
    @q = Role.ransack(params[:q])
    @roles = @q.result(distinct: true)
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    @role.status = 1
    if @role.save
      flash[:notice] = '创建成功'
      redirect_to :roles
    else
      flash[:notice] = '创建失败'
      render "/users/new"
    end
  end

  def destroy
    if @role.name != 'admin'
      if @role.update_attributes(status: 0)
        flash[:notice] = '删除成功'
      else
        flash[:notice] = '删除失败'
      end
    else
      flash[:notice] = 'admin角色不能删除'
    end
    redirect_to :roles
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
end
