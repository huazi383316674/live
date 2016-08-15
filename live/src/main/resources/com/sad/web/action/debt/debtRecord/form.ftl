[#ftl]
[@b.head/]
[@b.toolbar title="债务清单添加/更新"]
	bar.addBack();
[/@]

[#assign debtTypes = {'borrowIn':'借入', 'borrowOut':'借出'} /]

[@b.form name="debtRecordEditForm" action="!save" title="" theme="list"]
	[@b.textfield name="debtRecord.name" label="债务名称" value="${(debtRecord.name)!}" maxlength="200" required="true" style="width:220px" /]
	[@b.textfield name="debtRecord.debtUserName" label="债务人" value="${(debtRecord.debtUserName)!}" maxlength="200" required="true" style="width:220px" /]
	[@b.textfield name="debtRecord.amount" label="金额" value="${(debtRecord.amount)!}" maxlength="8" required="true" style="width:80px" /]
	[@b.select name="debtType" items=debtTypes! label="业务类型" empty="..." value=(debtRecord.debtType.getEngName())! required="true" style="width:225px" /]
	[@b.datepicker label="债务产生日期" required="true" name="debtRecord.createOn" id="createAt" value="${(debtRecord.createOn?string('yyyy-MM-dd'))?default('')}" style="width:225px"  format="yyyy-MM-dd" maxDate="#F{$dp.$D(\\'preAt\\')}" /]
	[@b.datepicker label="债务预归还日期" required="true" name="debtRecord.preReturnOn" id="preAt" value="${(debtRecord.preReturnOn?string('yyyy-MM-dd'))?default('')}" style="width:225px"  format="yyyy-MM-dd" minDate="#F{$dp.$D(\\'createAt\\')}" /]
	[@b.textarea cols="33" rows="2" label="备注" name="debtRecord.remark" maxlength="200" value="${(debtRecord.remark)!}" style="font-size:12px" /]
	
	[@b.formfoot]
		[@b.redirectParams /]
		<input type="button" value="保存" onclick="addIncomePaymentRecord()" />
		[#--<input type="button" value="直接保存" onclick="quickSave()" />
		<input type="button" value="保存并添加收支记录" onclick="addIncomePaymentRecord()" />--]
		<input type="reset" value="${b.text("action.reset")}" />
		<input type="hidden" name="debtRecord.id" value="${(debtRecord.id)!}" />
	[/@]
	
	<div style="display:none">
		<div id="incomePaymentDiv"></div>
	</div>
[/@]

<script>
	jQuery('div#colorbox').remove();
	jQuery('div#cboxOverlay').remove();
</script>
<script type="text/javascript" src="static/scripts/colorbox/jquery.colorbox-min.js"></script>
<script>
	function addIncomePaymentRecord() {
		bg.form.submit(document.debtRecordEditForm, "debtRecord!addIncomePaymentRecord.action", "incomePaymentDiv");
	}
	
	function quickSave() {
		alert(1);
		bg.form.submit(debtRecordEditForm, "debtRecord!quickSave.action", "contentDiv");
	}
</script>
[@b.foot/]