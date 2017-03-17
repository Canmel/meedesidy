class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  # skip_before_filter :verify_authenticity_token
  protect_from_forgery with: :null_session
  before_action :record_request

  # before_action :valid_login, except: [:new ,:edit, :show, :update]
  ADMIN_ROLE_ID = 2

  def valid_login
    redirect_to :users
  end

  def current_ability
    @current_ability ||= ::Ability.new(current_user)
  end

  def record_request
    @page = params[:page] ||= 1
    @page_size = params[:pageSize] ||= 10
  end

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if User.count == 1
        resource.add_role 'admin'
      end
      resource
    end
    root_path
  end

  def edit
  end

  def admin? user
   user.roles.include? Role.find(ADMIN_ROLE_ID)
  end

  def save_log( log_type, remark, **args)
    log = Log.new
    log.log_type = log_type
    log.remark = remark
    log.operater = args[:operater]
    log.operater ||= current_user
    log.car_id = args[:car_id]
    log.driver_id = args[:driver_id]
    log.company_id = args[:company_id]
    log.save
  end

  rescue_from CanCan::AccessDenied do |_exception|
    if current_user
      render file: "#{Rails.root}/public/422.html", status: 403, layout: false
    else
      redirect_to "/"
    end
  end
end
