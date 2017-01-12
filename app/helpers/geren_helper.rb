module GerenHelper
  def all_gerens
    Geren.where(status: Geren.statuses[:active])
  end
end
