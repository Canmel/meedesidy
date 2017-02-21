class CompaniesController < ApplicationController
  load_and_authorize_resource
  before_action :set_global_search_variable, only: [:index]

  def index
    @companies = @q.result.page(@page).per(@page_size)
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      flash_msg '新建公司成功'
      redirect_to :companies
    else
      render :new
    end
  end

  def new
    @company = Company.new
  end

  def update
    if @company.update(company_params)
      flash_msg '修改公司成功'
      redirect_to :companies
    else
      render :edit
    end
  end

  def destroy
    if @company.update(status: Company.statuses[:archived])
      flash_msg '删除成功'
    else
      flash_msg "删除失败: #{ @company.operat_error_msg }"
    end
    redirect_to :companies
  end

  private

  def set_company
    @company = Company.find(params[:id])
  end

  def flash_msg msg
    flash[:company_notice] = msg
  end

  def company_params
    params.require(:company).permit(:name, :id, :addr, :status, :phone, :contact_name, :contact_phone, :sort_name, :created_at, :updated_at)
  end

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    # params[:q][:status_eq] = Company.statuses[:active]
    @q = Company.ransack(params[:q])
  end
end
