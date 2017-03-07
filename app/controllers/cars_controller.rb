class CarsController < ApplicationController
  load_and_authorize_resource
  before_action :set_global_search_variable, only: :index
  autocomplete :driver, :name, :extra_data => [:phone]


  def index
    @car = Car.new
    @cars = @q.result.page(@page).per(@page_size)
    @cars.total_count
  end

  def create
    @car = Car.new(car_params)
    @car.status = Car.statuses[:archived]
    if @car.save
      flash_msg '创建车辆成功'
      save_log(Log.log_types[:basic], "#{current_user.name} 创建车辆 #{@car.car_no} 成功", car_id: @car.id)
      redirect_to :cars
    else
      flash_msg '创建车辆失败'
      render :new
    end
  end

  def update
    if @car.update(car_params)
      require 'qiniu'
      require 'rqrcode_png'
      require 'util/qiniu_util'
      return if Rails.env.test?
      QiniuUtil.deleteQiniuRqrcode car_no
      qr  = RQRCode::QRCode.new("#{car_no};#{change_status}", size: 6, level: :h)
      png = qr.to_img
      png.resize(200, 200).save("public/cars/rqrcode/temp_car.png")
      info = QiniuUtil.upload2qiniu!("public/cars/rqrcode/temp_car.png", car_no)

      flash_msg '修改车辆成功'
      save_log(Log.log_types[:basic], "#{current_user.name} 创建车辆 #{@car.car_no} 基础参数成功", car_id: @car.id)
      redirect_to :cars

    else
      flash_msg '修改车辆失败'
      render :edit
    end
  end

  def destroy
    if @car.update(status: 0)
      flash_msg '删除车辆成功'
      save_log(Log.log_types[:basic],"#{current_user.name} 删除车辆　#{@car.car_no} 成功", car_id: @car.id)
    else
      flash_msg "删除失败: #{@car.operat_error_msg}"
    end
    redirect_to :cars
  end

  # 发车
  # 造成数据库影响：
  # 1. car关联company
  # 2. company状态改为[激活]状态
  # 可以激活
  #   1. status = 0(入库)
  #   2. company.nil? == true
  def grant
    @car = Car.find(params[:id])
    if @car.present? && params[:company_id].present? && @car.godowned?
      @car.company_id = params[:company_id]
      @car.status = Car.statuses[:active]
      if @car.save
        flash_msg '发车成功'
        save_log(Log.log_types[:grant],
                 "#{current_user.name} 发车 #{@car.car_no} 至 #{@car.company.name} 成功",
                 car_id: @car.id,
                 company_id: @car.company.id)
        render :json => { :code => "200", :result => '发车成功' }
      else
        flash_msg '发车失败'
        render :json => { :code => "500", :result => '发车失败' }
      end
    else
      flash_msg '无法获取车辆信息或不是入库阶段，发车失败'
      render :json => { :code => '404', :result => '无法获取车辆信息，发车失败'}
    end
  end

  # 退款
  # 车必须是绑定状态
  def refund
    p @car
    p @car.binded?
    if @car.nil? || !@car.binded?
      render :json => { :code => '404', :result => '无法获取车辆信息或未绑定，发车失败'}
    else
      if @car.balance >= params[:refund_fee].to_f
        # 创建退款申请
        refund = Refund.new(car_id: @car.id, fee: params[:refund_fee], operater: current_user, status: Refund.statuses[:apply])


        return render :json => { :code => "200", :result => '申请已发出' } if refund.save
      else
        render :json => { :code => "500", :result => '退款金额不能大于余额' }
      end
    end
  end

# 绑定司机
# 造成数据库影响：
#   1. car 关联　司机driver
#   2. car 状态　为３　租赁中
#  可以绑定
#     1. car　状态为2 激活状态
#     2. car 没有关联　司机
  def bind_driver
    @car = Car.find(params[:id])
    if @car.binded?
      flash_msg "该车辆已经绑定过了"
      redirect_to :cars
    else
      @car.driver_id = car_params[:driver_id]
      @car.status = Car.statuses[:renting]
      @car.charge_rule_id = car_params[:settlementer]
      p @car
      if @car.valid_driver? && @car.save
        flash_msg "绑定车辆成功"
        save_log(Log.log_types[:bind],
                 "#{current_user.name}　绑定车辆　#{@car.car_no} 司机 #{@car.driver&.name} 成功",
                 car_id: @car.id, driver_id: @car.driver&.id, company_id: @car.company&.id)
        redirect_to :cars
      else
        render :bind
      end
    end
  end

  # 解绑车辆
  # 造成数据库影响：
  # 1. car 解除已关联的司机ID
  # 2. car 状态由３【租赁中】=> ２【激活】
  # 3. car 清除收费规则
  # 4. car 换电状态置为0
  # 解绑需要
  # 1. car 已经绑定了司机
  # 2. car 状态为３【租赁中】
  # 3. 绑定的车，有余额不能解绑
  def relieve
    if @car.balance?
      flash_msg '车辆有未使用余额，不能解绑'
      redirect_to :cars
      return
    end
    # 检查数据！如果不是符合要求的数据不予解绑
    if @car.binded?
      driver_id = @car.driver&.id
      @car.driver = nil
      @car.status = Car.statuses[:active]
      @car.charge_rule_id = nil
      @car.change_status = Car.change_statuses[:first_change]
      if @car.save
        flash_msg '解绑车辆成功'
        save_log(Log.log_types[:relieve],
                 "#{current_user.name}　解绑车辆　#{@car.car_no} 成功",
                 car_id: @car.id,
                 driver_id: driver_id,
                 company_id: @car.company&.id)
      else
        flash_msg '解绑车辆失败'
      end
    else
      flash_msg '车辆未绑定或无司机信息'
    end
    redirect_to :cars
  end

  # 退车
  # 造成数据库影响
  # 1. car 解除已关联的　公司
  # 2. car 状态由２【激活】　=> １【入库】
  # 退车需要
  #   1. car 未绑定司机
  #   2. car 状态为２【激活】
  #   3. 已绑定公司
  def back
    if @car.granted?
      company_id = @car.company&.id
      @car.status = Car.statuses[:archived]
      @car.company = nil
      if @car.save
        flash_msg '退车成功'
        save_log(Log.log_types[:back],
                 "#{current_user.name}　退车　#{@car.car_no} 成功", car_id: @car.id, company_id: company_id )
      else
        flash_msg '退车失败'
      end
    else
      flash_msg '数据不正确或该车辆不是激活状态'
    end
    redirect_to :cars
  end

  # 获取二维码url
  # 二维码保存在七牛，获取图片的链接
  def primitive_url
    require 'qiniu'
    car = Car.find(params[:id])
    file_name = car.car_no
    file_name ||= ""
    code, result, response_headers = Qiniu::Storage.stat(QINIU_BUCKET, "#{file_name}.png")
    if code == 200
      primitive_url = "http://olzjsogr4.bkt.clouddn.com/#{file_name}.png"
      download_url = Qiniu::Auth.authorize_download_url(primitive_url)
      render json: { :code => '200' ,:name => car.car_no , :data => download_url } if download_url.present?
    else
      render json: { code: 'error' ,msg: 'no such file or directory'}
    end
  end

  private
  def car_params
    params.require(:car).permit(:car_no, :vin, :color, :geren_id, :company_id, :driver_id, :operater, :settlementer, :refund_fee)
  end

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    @q = Car.ransack(params[:q])
  end

  def flash_msg msg
    flash[:car_notice] = msg
  end
end
