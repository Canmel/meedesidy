class RolesController < ApplicationController
  before_action :set_role, only: [:show, :edit, :update, :destroy]

  def index
    @q = Role.ransack(params[:q])
    @roles = @q.result(distinct: true)
  end

  def new
    @role = Role.new
  end

  def create
    @role = Role.new(role_params)
    @role.save
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
