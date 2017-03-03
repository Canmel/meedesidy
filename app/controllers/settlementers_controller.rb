class SettlementersController < ApplicationController
  load_and_authorize_resource
  before_action :set_global_search_variable, only: [:index]

  def index
    @settlementers = @q.result.page(@page).per(@page_size)
  end

  private

  def set_global_search_variable
    params[:q] ||= ActionController::Parameters.new
    params[:q][:status] ||= Settlementer.statuses[:active]
    @q = Settlementer.ransack(params[:q])
  end
end
