class Ability
  include CanCan::Ability
  def initialize(user)
    if user.blank?
      cannot :manage, :all
      ####超级管理员权限####
    elsif user.has_role? :admin
      can :manage, :all
      ####店长权限####
    elsif user.has_role? "店长"
      #####显示属于自己的店铺#####
      can :show, Shop do |shop|
        (shop.admin_id == user.id)
      end
      #####显示属于自己店铺列表#####
      can :my_shop, Shop do |shop|
        (shop.admin_id == user.id)
      end
      ####编辑修改属于自己的店铺####
      can :update, Shop do |shop|
        (shop.admin_id == user.id)
      end
      #######切换店铺开关状态#######
      can :switch, Shop do |shop|
        (shop.admin_id == user.id)
      end
      ######管理所有本店铺的理发师######
      can :manage, Barber
      ####管理本店铺的服务####
      can :manage, ShopService
      ####查看所有的服务模板####
      can :read, Service
      ###看到属于自己的订单统计###
      can :stat, Order
    end
  end
end
