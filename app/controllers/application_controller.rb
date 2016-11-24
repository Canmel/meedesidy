class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  layout :test

  ADMIN_ROLE_ID = 2

  def after_sign_in_path_for(resource)
    if resource.is_a?(User)
      if User.count == 1
        resource.add_role 'admin'
      end
      resource
    end
    root_path
  end

  def admin? user
   user.roles.include? Role.find(ADMIN_ROLE_ID)
  end
  # rescue_from CanCan::AccessDenied do |exception|
  #   redirect_to "/", :alert => exception.message
  # end
protected
  def test
    if current_user
      'application'
    else
      false
    end
  end
end
