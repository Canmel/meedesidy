module UsersHelper
  def all_role
    Role.where(status: Role.statuses[:active])
  end
end
