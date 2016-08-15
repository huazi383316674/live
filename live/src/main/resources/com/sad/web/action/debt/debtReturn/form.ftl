[#ftl]
[@b.head/]
[@b.toolbar title="添加/更新债务归还清单" /]

<script>
	function validateNum() {
		var reg = /^[+|-]?\d*\.?\d*$/; return reg.test(document.debtReturnEditForm["debtReturnRecord.amount"].value);
	}
	
	function addInPay() {
		bg.form.submit(document.debtReturnEditForm, "debtReturn!addInPay.action"); 
	}
	
	jQuery('div#colorbox').remove();
	jQuery('div#cboxOverlay').remove();
</script>
<script type="text/javascript" src="static/scripts/colorbox/jquery.colorbox-min.js"></script>

[@b.form name="debtReturnEditForm" theme="list" target="inPayByReturnDiv"]
	[@b.textfield name="debtReturnRecord.amount" label="归还金额" value="${(debtReturnRecord.amount)!}" maxlength="8" required="true" style="width:80px" check="assert(validateNum, '归还金额格式有误');"/]
	[@b.datepicker label="归还日期" required="true" name="debtReturnRecord.returnOn" value="${(debtReturnRecord.returnOn?string('yyyy-MM-dd'))!}" style="width:140px" /]
	[@b.textfield label="备注" name="debtReturnRecord.remark" value="${(debtReturnRecord.remark)!}" maxlength="200" style="width:140px" /]
	[@b.formfoot]
		[@b.redirectParams /]
		<input type="button" value="${b.text("action.save")}" onclick="addInPay()" />
		<input type="reset" value="${b.text("action.reset")}" />
		<input type="hidden" name="debtReturnRecord.debtRecord.id" value="${Parameters['debtRecordId']}" />
		<input type="hidden" name="debtReturnRecord.id" value="${(debtReturnRecord.id)!}" />
	[/@]
	
	<div style="display:none">
		<div id="inPayByReturnDiv"></div>
	</div>
[/@]
[@b.foot/]