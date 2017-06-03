module WorkFlowsHelper
  def formtable_show(flow)
    flow.formtable? ? "有" : "无"
  end

  def confirm_modal_render
    "<div class='modal fade' id='qrCodeModal' tabindex='-1' role='dialog' aria-labelledby='qrCodeModal' aria-hidden='true'>
      <div class='modal-dialog'>
      <div class='modal-content' style='width: 400px;margin-left: 100px;' align='center'>
      <div class='modal-header meedesidy_bg_1'>
      <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
            <h4 class='modal-title' id='qrCodeLabel'>请给定流程名称</h4>
      </div>
          <div class='modal-body' id='qr_modal_div'>
      </div>
      <form class='pjax-form form-horizontal' role='form' id='new_flow_form' action='/work_flows' accept-charset='UTF-8' method='post'>
          <input name='work_flow[content]' id='work_flow_content' type='hidden'>
          <div class='form-group'>
          <label class='control-label col-sm-2 required' for='car_car_no'>流程名称</label>
          <div class='col-sm-10'>
            <input class='form-control' type='text' name='work_flow[name]'>
          </div>
        </div>
      </form>
      <div class='modal-footer meedesidy_bg_2'>
      <button type='button' class='btn btn-default' data-dismiss='modal' id='comfirm_btn'>确认</button>
          </div>
      </div>
      </div>
    </div>".html_safe
  end
end
