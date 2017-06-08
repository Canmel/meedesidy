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
      manage_work_flow
      manage_date
      manage_finance
    elsif user.has_role? :finance
      ###财务权限###
      manage_finance
    end
  end

  private

  def manage_date
    can :manage, Car
    can :manage, Geren
    can :manage, Driver
    can :manage, Company
  end

  def manage_finance
    can :manage, Finance
    can :manage, Refund
  end

  def manage_work_flow
    can :manage, WorkFlow
    can :manage, Flow
    can :manage, Task
  end

  def no_role
    can :login_app, User
  end
end
