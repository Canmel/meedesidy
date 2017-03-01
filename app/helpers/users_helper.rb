module UsersHelper
  def all_role
    Role.where(status: Role.statuses[:active])
  end

  def downloadFromqiniu(fileName)
    require 'qiniu'

    primitive_url = "http://olzjsogr4.bkt.clouddn.com/#{fileName}"
    download_url = Qiniu::Auth.authorize_download_url(primitive_url)
  end

  def qrcode_modal_render
  "<div class='modal fade' id='myModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
  <div class='modal-dialog'>
  <div class='modal-content' style='width: 400px;margin-left: 100px;' align='center'>
  <div class='modal-header'>
  <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
        <h4 class='modal-title' id='myModalLabel'>正在加载。。。</h4>
  </div>
      <div class='modal-body' id='modal_div'>
      </div>
  <div class='modal-footer'>
  <button type='button' class='btn btn-default' data-dismiss='modal'>确认</button>
      </div>
  </div>
  </div>
  </div>".html_safe
  end
end
