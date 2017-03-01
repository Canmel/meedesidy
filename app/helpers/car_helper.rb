module CarHelper

  def car_company_render car
    car.company.present? ? car.company&.sort_name : "未发车"
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

  def bind_car_render car
    link_to '绑定', bind_car_path(car), class: 'label meedesidy_btn_2' if car.active? || car.company.present?
  end

  def all_car_operate_type
    Car.operate_types_i18n.map{ |item| [item[1], item[0]] }
  end
end
