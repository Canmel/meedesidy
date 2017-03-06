module CarHelper

  def car_company_render car
    car.company.present? ? car.company&.sort_name : "未发车"
  end

  def car_qr_code_render car
    "<a class='label meedesidy_btn_1' href='##' data-toggle='modal' data-target='#qrCodeModal' name = 'qr_code' car_id='#{car.id}'>二维码</a>".html_safe
  end

  def car_qr_code_modal_render
    "<div class='modal fade' id='qrCodeModal' tabindex='-1' role='dialog' aria-labelledby='qrCodeModal' aria-hidden='true'>
      <div class='modal-dialog'>
      <div class='modal-content' style='width: 400px;margin-left: 100px;' align='center'>
      <div class='modal-header meedesidy_bg_1'>
      <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
            <h4 class='modal-title' id='qrCodeLabel'>正在加载。。。</h4>
      </div>
          <div class='modal-body' id='qr_modal_div'>
          </div>
      <div class='modal-footer meedesidy_bg_2'>
      <button type='button' class='btn btn-default' data-dismiss='modal'>确认</button>
          </div>
      </div>
      </div>
    </div>".html_safe
  end
  
  def model_render
    "<div class='modal fade' id='myModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='false'>
      <div class='modal-dialog'>
    <div class='modal-content' align='center'>
      <div class='modal-header meedesidy_bg_1'>
        <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
        <h4 class='modal-title' id='myModalLabel'>正在加载。。。</h4>
      </div>
      <div class='modal-body' id='modal_div'>
        <div>
          <table style='width: 600px;'>
            <tr>
              <td id='car_info' style='width: 40%;'>
                <div class='form-group'>
                  <label class='control-label col-sm-4 required' for='car_car_no'>车牌号</label>
                  <div class='col-sm-6'>
                  <p class='form-control-static' id='p_company' style='color: #000000;'></p>
                </div>
                </div><br/>
                  <div class='form-group'>
                  <label class='control-label col-sm-4 required' for='car_car_no'>车型</label>
                  <div class='col-sm-6'>
                  <p class='form-control-static' id='p_geren' style='color: #000000;'></p>
                  </div>
                </div>
              </td>
              <td style='width: 1px; background-color: rgba(0, 0, 0, 0.25); '></td> <td>
                <input type='hidden' name='id'>
                <div class='form-group'><label class='control-label col-sm-4' for='car_company_id'>发往服务公司</label><div class='col-sm-6'>
                <select class='form-control' name='car[company_id]' id='car_company_id'>
                   #{all_companies_options}
                </select>
                </div>
                </div>
              </td>
            </tr>
          </table>
        </div>
      </div>
      <div class='modal-footer meedesidy_bg_2' style='padding: 3px 22px 5px;'>
        <button type='button' class='btn meedesidy_btn_confirm' id='grant_confirm'>确认</button>
        <!--<button type='button' class='btn btn-primary'>确认</button>-->
      </div>
      </div>
    </div>
    </div>".html_safe
  end

  def back_modal_render
    "<div class='modal fade' id='backModal' tabindex='-1' role='dialog' aria-labelledby='backModalLabel'>
      <div class='modal-dialog'>
    <div class='modal-content' align='center'>
      <div class='modal-header meedesidy_bg_1'>
        <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
        <h4 class='modal-title' id='backModalLabel'>正在加载。。。</h4>
      </div>
      <div class='modal-body' id=''>
        <div>
          <table style='width: 600px;'>
            <tr>
              <td id='car_info' style='width: 40%;'>
                <div class='form-group'>
                  <label class='control-label col-sm-4 required' for='car_car_no'>车牌号</label>
                  <div class='col-sm-6'>
                  <p class='form-control-static' id='back_car_no' style='color: #000000;'></p>
                </div>
                </div><br/>
                <div class='form-group'>
                  <label class='control-label col-sm-4 required' for='car_car_no'>车型</label>
                  <div class='col-sm-6'>
                  <p class='form-control-static' id='back_geren' style='color: #000000;'></p>
                  </div>
                </div>
                <br/>
              </td>
              <td style='width: 1px; background-color: rgba(0, 0, 0, 0.25); '></td> <td>
                <input type='hidden' name='id'>
                <div class='form-group'>
                  <label class='control-label col-sm-4 required' for='car_car_no'>公司</label>
                  <div class='col-sm-6'>
                  <p class='form-control-static' id='back_company' style='color: #000000;'></p>
                  </div>
                </div>
              </td>
            </tr>
          </table>
        </div>
      </div>
      <div class='modal-footer meedesidy_bg_2' style='padding: 3px 22px 5px;'>
          <a class='btn meedesidy_btn_confirm' data-dismiss='modal' id='back_btn'>退车</a>
      </div>
      </div>
    </div>
    </div>".html_safe
  end

  def relieve_modal_render
    "<div class='modal fade' id='relieveModal' tabindex='-1' role='dialog' aria-labelledby='relieveModalLabel' aria-hidden='false'>
      <div class='modal-dialog'>
    <div class='modal-content' align='center'>
      <div class='modal-header meedesidy_bg_1'>
        <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
        <h4 class='modal-title' id='relieveModalLabel'>正在加载。。。</h4>
      </div>
      <div class='modal-body' id=''>
        <div>
          <table style='width: 600px;'>
            <tr>
              <td id='car_info' style='width: 40%;'>
                <div class='form-group'>
                  <label class='control-label col-sm-4 required' for='car_car_no'>车牌号</label>
                  <div class='col-sm-6'>
                  <p class='form-control-static' id='relieve_car_no' style='color: #000000;'></p>
                </div>
                </div><br/>
                <div class='form-group'>
                  <label class='control-label col-sm-4 required' for='car_car_no'>车型</label>
                  <div class='col-sm-6'>
                  <p class='form-control-static' id='relieve_geren' style='color: #000000;'></p>
                  </div>
                </div>
                <br/>
                <div class='form-group'>
                  <label class='control-label col-sm-4 required' for='car_car_no'>公司</label>
                  <div class='col-sm-6'>
                  <p class='form-control-static' id='relieve_company' style='color: #000000;'></p>
                  </div>
                </div>
              </td>
              <td style='width: 1px; background-color: rgba(0, 0, 0, 0.25); '></td> <td>
                <input type='hidden' name='id'>
                <div class='form-group'><label class='control-label col-sm-4' for='car_company_id'>当前绑定司机</label><div class='col-sm-6'>
                <p class='form-control-static' id='relieve_driver' style='color: #000000;'></p>
                </div>
                </div>
              </td>
            </tr>
          </table>
        </div>
      </div>
      <div class='modal-footer meedesidy_bg_2' style='padding: 3px 22px 5px;'>
          <a data-confirm='确认要解绑吗?' class='btn meedesidy_btn_confirm' id='relieve_btn'>解绑</a>
      </div>
      </div>
    </div>
    </div>".html_safe
  end

  def all_companies_options
    html_str = ""
    all_company.each do |item|
      html_str << "<option value='#{item.id}' >#{item.name}</option>"
    end
    html_str
  end

  def grant_car_render car
    "<a class='label meedesidy_btn_1' modal_car_no='#{car.car_no}' modal_car_geren='#{car.geren&.name}' data-toggle='modal' href='##' data-target='#myModal' name='grant' data='#{car.id}'>发车</a>".html_safe if car.archived? || car.company_id.nil?
  end

  def back_car_render car
    "<a class='label meedesidy_btn_2' modal_car_no='#{car.car_no}' modal_car_geren='#{car.geren&.name}' modal_car_company='#{car.company&.name}' data-toggle='modal' href='##' data-target='#backModal' name='back' data='#{car.id}'>退车</a>".html_safe if car.active? && car.company.present? && car.driver.nil?
  end

  def bind_car_render car
    if car.granted? && !car.binded?
      # 已经发车｜未绑定
      link_to '绑定', bind_car_path(car), class: 'label meedesidy_btn_2'
    else
      if car.binded?
        # 已绑定
        "<a class='label meedesidy_btn_1'
         modal_car_no='#{car.car_no}' modal_company='#{car.company&.name}' modal_driver='#{car.driver&.name}' modal_car_geren='#{car.geren&.name}'
         data-toggle='modal' href='##' data-target='#relieveModal' name='relieve' data='#{car.id}'>解绑</a>".html_safe
      end
    end
  end

  def all_car_operate_type
    Car.operate_types_i18n.map{ |item| [item[1], item[0]] }
  end

  def edit_car_render car
    link_to '编辑', edit_car_path(car), class: 'label meedesidy_btn_edit' if car.archived?
  end

  def delete_car_render car
    link_to '删除', car, data: {confirm: "确认要删除#{car.car_no}?"}, method: :delete, class: 'label meedesidy_btn_delete' if car.archived?
  end
end
