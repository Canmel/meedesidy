module RefundsHelper
  def reject_modal_render
    "<div class='modal fade' id='myModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
    <div class='modal-dialog'>
    <div class='modal-content'>
    <div class='modal-header'>
    <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>
    &times;
    </button>
				<h4 class='modal-title text-center' id='myModalLabel'>
					驳回原因
				</h4>
    </div>
			<div class='modal-body'>
				<form class='pjax-form form-horizontal' id='reject_form'>
          <input type='hidden' name='id'>
          <div class='form-group'>
            <label class='control-label col-sm-2' for='finance_remark'>原因</label>
            <div class='col-sm-10'>
              <input class='form-control' type='text' name='refund[remark]' id='refund_remark'>
            </div>
          </div>
        </form>
			</div>
    <div class='modal-footer'>
    <button type='button' class='btn btn-default' data-dismiss='modal'>关闭
    </button>
				<button type='button' class='btn btn-primary' id='refund_sub_btn'>
					提交更改
				</button>
    </div>
		</div>
	</div>
</div>".html_safe
  end
end
