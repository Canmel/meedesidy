class DriversController < ApplicationController
  before_action :set_global_search_variable, only: :index
  before_action :set_driver, only: [:show, :edit, :update, :destroy]

  def index
    @drivers = @q.result.page(@page).per(@page_size)
  end

  def new
    @driver = Driver.new
  end

  def create
    @driver = Driver.new(driver_params)
    @driver.updater = current_user
    if @driver.save
      flash_msg '创建成功'
      redirect_to :drivers
    else
      render :new
    end
  end

  def update
    if @driver.update(driver_params)
      flash_msg '修改成功'
      redirect_to :drivers
    else
      render :edit
    end
  end

  def search_company
    key_word = params[:term]
    @companies = Company.where("name like '%#{key_word}%'")
    render :json => @companies.map{|company| {id: company.id, label: company.name, value: company.name, name: company.name}}
  end


  private
  def set_driver
    @driver = Driver.find(params[:id])
  end
  # Never trust parameters from the scary internet, only allow the white list through.
  def driver_params
    params.require(:driver).permit(:name, :id, :id_card_no, :status, :phone, :desc, :sex, :company_id, :entry_time)
  end

  def flash_msg msg
    flash[:driver_notice] = msg
  end

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status_eq] = Car.statuses[:active]
    @q = Driver.ransack(params[:q])
  end
end
