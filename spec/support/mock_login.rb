module MockLogin
  # @param [Symbol] role 希望登录的用户角色
  # @return [User] 当前登录用户的实例
  def sign_in_as(role)
    role_name = "#{role}_role"
    user      = FactoryGirl.create(:user_admin)
    user.roles << FactoryGirl.create(role_name)

    session[:user_id] = user.id
    session[:name]    = user.name

    controller.instance_variable_set(:@current_user, user)

    user
  end
end
