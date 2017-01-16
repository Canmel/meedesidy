class CompaniesController < ApplicationController
  before_action :set_global_search_variable, only: [:index]

  def index
    @companies = @q.result.page(@page).per(@page_size)
  end

  def update
    @company.update(company)
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to :companies
    else
      render :new
    end
  end

  def new
    @company = Company.new
  end

  private

  def company_params
    params.require(:company).permit(:name, :id, :addr, :status, :phone, :contact_name, :contact_phone, :sort_name, :created_at, :updated_at)
  end

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] = Company.statuses[:active]
    @q = Company.ransack(params[:q])
  end
end
