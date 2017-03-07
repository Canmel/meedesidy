module FinancesHelper
  def submit_info_modal_render
    "<div class='modal fade' id='submitModal' tabindex='-1' role='dialog' aria-labelledby='submitModal' aria-hidden='true'>
      <div class='modal-dialog'>
      <div class='modal-content' align='center' style=''>
      <div class='modal-header meedesidy_bg_1'>
          <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
          <h4 class='modal-title' id='submitLabel'>充值确认信息</h4>
      </div>
      <div class='modal-body' id='submit_div'>
      </div>
      <div class='modal-footer meedesidy_bg_2'>
      <button type='button' class='btn btn-default' data-dismiss='modal' id='confirm'>确认</button>
          </div>
      </div>
      </div>
    </div>".html_safe
  end

  def show_finance_modal_render
    "<div class='modal fade' id='showModal' tabindex='-1' role='dialog' aria-labelledby='showModal' aria-hidden='true'>
      <div class='modal-dialog'>
      <div class='modal-content'>
      <div class='modal-header meedesidy_bg_1'>
      <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
            <h4 class='modal-title' id='showLabel'>充值记录</h4>
      </div>
          <div class='modal-body' id='show_div'>
            <table style='width: 600px;'>
            <tr>
              <td id='car_info' style='width: 80%;'>
                <div class='form-group'>
                  <label class='control-label col-sm-4 required' for='car_car_no'>充值账号</label>
                  <div class='col-sm-6'>
                  <p class='form-control-static' id='charge_account' style='color: #000000;'></p>
                </div>
                </div><br/>
                <div class='form-group'>
                  <label class='control-label col-sm-4 required' for='car_car_no'>充值金额</label>
                  <div class='col-sm-6'>
                  <p class='form-control-static' id='charge_fee' style='color: #000000;'></p>
                  </div>
                </div><br/>
                <div class='form-group'>
                  <label class='control-label col-sm-4 required' for='car_car_no'>充值时间</label>
                  <div class='col-sm-6'>
                  <p class='form-control-static' id='charge_time' style='color: #000000;'></p>
                  </div>
                </div>
              </td>
              <td style='width: 1px; background-color: #fff; '></td> <td>
              </td>
            </tr>
          </table>
          </div>
      <div class='modal-footer meedesidy_bg_2'>
      <button type='button' class='btn btn-default' data-dismiss='modal'>确认</button>
          </div>
      </div>
      </div>
    </div>".html_safe
  end

  def get_account_num record
    record.car.present? ? record.car.car_no : record.account_num
  end

  def get_datas record
    record.created_at = record.created_at.to_s(:full)
    record.to_json
  end
end
