class UsersController < ApplicationController
  load_and_authorize_resource
  before_action :set_user, only: [:show, :edit, :update, :destroy, :qrcode]
  # before_filter :authenticate_user!
  respond_to :html

  def index
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] ||= User.statuses[:active]
    params[:q][:s] = 'id desc'
    @q = User.ransack(params[:q])
    @users = @q.result.page(@page).per(@page_size)
    @users.total_count
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash_msg '创建用户成功'
      save_log(Log.log_types[:sys], "#{current_user.name} 创建用户 #{@user.name} 成功！")
      redirect_to '/users'
    else
      flash_msg '创建用户失败'
      render :new
    end
  end

  def update
    if @user.update_without_password(user_params)
      flash_msg '修改用户成功'
      redirect_to :users
      save_log(Log.log_types[:sys], "#{current_user.name} 修改用户 #{@user.name} 成功！")
    else
      flash_msg '修改用户失败'
      render :edit
    end
  end

  def destroy
    if admin? @user
      flash_msg "超级管理员不能删除"
    else
      if @user.update_attribute(:status, User.statuses[:archived])
        flash_msg "删除成功"
        save_log(Log.log_types[:sys], "#{current_user.name} 删除用户 #{@user.name} 成功！")
      else
        flash_msg '删除失败'
      end
    end
    redirect_to :users
  end

  # app登录借口，不需要权限
  def login_app
    # user = User.authenticate(params[:username], params[:password])
    if params[:username] == '0000' && params[:password] == '1111'
      render json: { :code => '200' , :msg => '登陆成功' }
    else
      render json: { :code => '304' , :msg => '登陆失败，请检查您的用户名密码' }
    end

  end

  # 获取用户二维码地址
  def primitive_url
    require 'qiniu'
    user = User.find(params[:id])
    file_name = user&.email&.split('@')[0]
    file_name ||= ""
    code, result, response_headers = Qiniu::Storage.stat(QINIU_BUCKET, "#{file_name}.png")
    if code == 200
      primitive_url = "http://olzjsogr4.bkt.clouddn.com/#{file_name}.png"
      download_url = Qiniu::Auth.authorize_download_url(primitive_url)
      render json: { :code => '200' ,:name => user.name , :data => download_url } if download_url.present?
    else
      render json: { code: 'error' ,msg: 'no such file or directory'}
    end
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
  
  def flash_msg msg
    flash[:user_notice] = msg
  end
end

