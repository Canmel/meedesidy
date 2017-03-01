class DriversController < ApplicationController
  load_and_authorize_resource
  before_action :set_global_search_variable, only: :index

  def index
    respond_to do |format|
      format.html do
        @drivers = @q.result.page(@page).per(@page_size)
      end
      format.json do
        render json: @driver.to_json
      end
    end
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

  def destroy
    if @driver.update(status: Driver.statuses[:archived])
      flash_msg '删除成功'
    else
      flash_msg '删除失败'
    end
    redirect_to :drivers
  end

  # def search_company
  #   key_word = params[:term]
  #   @companies = Company.where("name like '%#{key_word}%'")
  #   render :json => @companies.map{|company| {id: company.id, label: company.name, value: company.name, name: company.name}}
  # end


  private
  def driver_params
    params.require(:driver).permit(:name, :id, :id_card_no, :status, :phone, :desc, :sex, :company_id, :entry_time)
  end

  def flash_msg msg
    flash[:driver_notice] = msg
  end

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    # params[:q][:status_eq] = Car.statuses[:active]
    @q = Driver.ransack(params[:q])
  end
end
