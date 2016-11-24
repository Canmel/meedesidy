class UsersController < ApplicationController
  before_filter :authenticate_user!
  def index
    @q = User.ransack(params[:q])
    @users = @q.result(distinct: true)
  end

  def new
    @user = User.new
  end

  def create_user
    @user.save
    redirect_to :users
  end
end
