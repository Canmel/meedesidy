module DriversHelper
  def sex_array
    Driver.sexes_i18n.map{ |sex| [ sex[1], sex[0]] }
  end

  def companies_array
    Company.where(status: 1).map{ |company| [company.name, company.id] }
  end

  def drivers_status_colect
    @driver_status = []
    @driver_status << { "k" => Driver.statuses[:activate], "v" => "可用" }
    @driver_status << { "k" => Driver.statuses[:archived], "v" => "删除" }
  end
end
