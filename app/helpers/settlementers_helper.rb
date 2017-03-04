module SettlementersHelper
  def settlements_array
    Settlementer.all.map{ |company| [company.name, company.id] }
  end
end
