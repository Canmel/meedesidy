module CompaniesHelper

  def company_status_colect
    @company_status = []
    @company_status << { "k" => "1", "v" => "可用" }
    @company_status << { "k" => "0", "v" => "删除" }
  end

  def all_company
    Company.where( status: Company.statuses[:active] )
  end
end
