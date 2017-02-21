module DriversHelper
  def sex_array
    Driver.sexes_i18n.map{ |sex| [ sex[1], sex[0]] }
  end

  def companies_array
    Company.where(status: 1).map{ |company| [company.name, company.id] }
  end

  def drivers_colect
    @driver_status = []
    @driver_status << { "k" => "1", "v" => "可用" }
    @driver_status << { "k" => "0", "v" => "删除" }
  end
end
