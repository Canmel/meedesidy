module WorkFlowsHelper
  def formtable_show(flow)
    flow.formtable? ? "有" : "无"
  end

  def formtables
    Menu.two_level.active.map{|m| [m.name, m.id]}
  end

  def confirm_modal_render
    "<div class='modal fade' id='qrCodeModal' tabindex='-1' role='dialog' aria-labelledby='qrCodeModal' aria-hidden='true'>
      <div class='modal-dialog'>
      <div class='modal-content' align='center'>
      <div class='modal-header meedesidy_bg_1'>
      <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times;</button>
            <h4 class='modal-title' id='qrCodeLabel'>请给定流程名称</h4>
      </div>
          <div class='modal-body' id='qr_modal_div'>
      </div>
      #{bootstrap_form_for(@work_flow, layout: :horizontal, :html => { class: 'pjax-form' }) do |f|
        f.hidden_field :content, label: '流程内容', help: '必填'
        f.text_field :name, label: '流程名称'
        f.text_field :status, label: '流程名称'
        f.text_field :name, label: '流程名称'
        f.text_field :name, label: '流程名称'
        end}
      <div class='modal-footer meedesidy_bg_2'>
      <button type='button' class='btn btn-default' data-dismiss='modal' id='comfirm_btn'>确认</button>
          </div>
      </div>
      </div>
    </div>".html_safe
  end
end
