class BudgetsController < ApplicationController

  def index

  end

  private

  def set_budget
    @budget = Budget.find(params[:id])
  end

  def budget_params
    params.require(:budget).permit(:name, :id, :desc, :sponsor, :source, :resource_type, :icon_id)
  end
end
