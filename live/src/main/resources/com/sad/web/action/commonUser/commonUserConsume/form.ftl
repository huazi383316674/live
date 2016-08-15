[#ftl]
[@b.head/]
[@b.toolbar title="添加/更新消费信息"]
	bar.addBack();
[/@]

<script>
	function validateNum() {
		var reg = /^[+|-]?\d*\.?\d*$/; return reg.test(document.consumeEditForm["consume.amount"].value);
	}
</script>

[@b.form name="consumeEditForm" action="!save" title="" theme="list"]
	[@b.select label="姓名" name="consume.commonUser.id" items=commonUsers! value=(consume.commonUser.id)! empty="..." required="true" style="width:140px" /]
	[@b.field label="业务类型" required="true"]
		<select name="consume.businessType.id" style="width:140px">
		 	<option value="1" [#if (consume.businessType.id)?default(0)=1]selected=selected[/#if]>充值</option>
		 	<option value="2" [#if (consume.businessType.id)?default(0)=2]selected=selected[/#if]>消费</option>
	 	</select>
	[/@]
	[@b.textfield name="consume.amount" label="金额" value="${(consume.amount)!}" maxlength="4" required="true" style="width:60px" check="assert(validateNum, '金额格式有误');" /]
	[@b.datepicker readOnly="readOnly" label="日期" required="true" name="consume.createOn" value="${(consume.createOn?string('yyyy-MM-dd'))!}" style="width:135px"  format="yyyy-MM-dd" /]
	[@b.textfield name="consume.remark" label="备注" value="${(consume.remark)!}" maxlength="200" style="width:300px" /]
	[@b.formfoot]
		<input type="hidden" name="consume.id" value="${(consume.id)!}" />
		[@b.redirectParams/]
		[@b.submit value="${b.text('action.save')}"/]
		<input type="reset" value="${b.text("action.reset")}" />
	[/@]
[/@]
[@b.foot/]