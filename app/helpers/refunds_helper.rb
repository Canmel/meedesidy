module RefundsHelper
  def reject_modal_render
    "<div class='modal fade' id='myModal' tabindex='-1' role='dialog' aria-labelledby='myModalLabel' aria-hidden='true'>
     <div class='modal-dialog'>
     <div class='modal-content'>
       <div class='modal-header meedesidy_bg_1'>
       <button type='button' class='close' data-dismiss='modal' aria-hidden='true'>&times; </button>
          <h4 class='modal-title text-center' id='myModalLabel'>备注</h4>
      </div>
			<div class='modal-body'>
				<form class='pjax-form form-horizontal' id='reject_form' method='post'>
          <input type='hidden' name='id'>
          <div class='form-group'>
            <label class='control-label col-sm-2' for='finance_remark'>备注</label>
            <div class='col-sm-10'>
              <input class='form-control' type='text' name='refund[remark]' id='refund_remark'>
            </div>
          </div>
        </form>
			</div>
    <div class='modal-footer meedesidy_bg_2'>
    <button type='button' class='btn btn-default reject_refund_btn' data-dismiss='modal' id='reject_btn'>驳回
    </button>
				<button type='button' class='btn reject_refund_btn' id='agree_btn' >
					同意
				</button>
    </div>
		</div>
	</div>
</div>".html_safe
  end
end
