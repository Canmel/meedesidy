module DriversHelper
  def sex_array
    Driver.sexes_i18n.map{ |sex| [ sex[1], sex[0]] }
  end

  def companies_array
    Company.where(status: 1).map{ |company| [company.name, company.id] }
  end
end
