class UsersController < ApplicationController
  # load_and_authorize_resource param_method: :user_params
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  # before_filter :authenticate_user!
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.save
    redirect_to :users
  end

  def edit
  end

  def update
    @user.update_without_password(user_params)
    redirect_to :users
  end

  def destroy
    if admin? @user
      flash[:notice] = "超级管理员不能删除"
    else
      if @user.update_attribute(:status, User.statuses[:archived])
        flash[:notice] = "删除成功"
      else
          flash[:notice] = '删除失败'
      end
    end
    redirect_to :users
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :id, :password ,:email ,:role_ids => [])
  end
end
