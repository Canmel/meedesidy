class FlowsController < ApplicationController
  load_and_authorize_resource

  def show
    render json: {content: @flow.work_flow.content.to_s}
  end

  private
  def flow_params
    params.require(:flow).permit(:name, :formtable, :work_flow_id, :status, :state, :content)
  end
end
