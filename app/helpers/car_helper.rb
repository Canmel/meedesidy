module CarHelper
  
  def model_render
    "<div class='modal fade' id='myModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
      <div class='modal-dialog'>
    <div class='modal-content' align='center'>
      <div class='modal-header'>
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
              <form class='pjax-form form-horizontal' role='form' id='new_car' action='/cars' accept-charset='UTF-8' method='post'>
                <input name='utf8' type='hidden' value='✓'>
                <input type='hidden' name='authenticity_token' value='HSoeb7nUxTZWu/agiISqy3gKbBmyGc036BkhxI0O5KI4ROQrjT2DJTbbYrZMvdYL1GouBBIG5J8OlENBdQfTjw=='>
                <div class='form-group'><label class='control-label col-sm-4' for='car_company_id'>发往服务公司</label><div class='col-sm-6'>
                <select class='form-control' name='car[company_id]' id='car_company_id'>
                   #{options}
                </select>
                </div>
                </div></form>
              </td>
            </tr>

          </table>
        </div>
      </div>
      <div class='modal-footer'>
        <button type='button' class='btn btn-default' data-dismiss='modal'>确认</button>
        <!--<button type='button' class='btn btn-primary'>确认</button>-->
      </div>
      </div>
    </div>
    </div>".html_safe
  end

  def options
    html_str = ""
    all_company.each do |item|
      p item
      html_str << "<option>#{item.name}</option>"
    end
    p html_str
    html_str
  end

end
