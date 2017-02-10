class Ability
  include CanCan::Ability
  def initialize(user)
    user ||= User.new
    can :manage, :Driver

    no_role

    if user.blank?
      cannot :manage, :all
      ####超级管理员权限####
    elsif user.has_role? :admin
      can :manage, :all
      ####店长权限####
    elsif user.has_role? :daily_manager
      manage_date
    end
  end

  private

  def manage_date
    can :manage, Car
    can :manage, Geren
    can :manage, Driver
    can :manage, Company
  end

  def no_role
    can :login_app, User
  end
end
