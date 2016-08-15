[#ftl]
[@b.head/]
[@b.toolbar title="${coder.name}添加/更新"]
	bar.addBack();
[/@]

[@b.form name="modelEditForm" action="!save" title="" theme="list"]
	[@b.textfield id="model.code" name="model.code" label="代码" value="${(model.code)!}" maxlength="3" required="true" style="width:120px" /]
	[@b.textfield id="model.name" name="model.name" label="名称" value="${(model.name)!}" maxlength="80" required="true" style="width:120px" /]
	[@b.select name="model.businessType.id" items=businessTypes?sort_by("code")! label="业务类型" value=(model.businessType.id)! empty="..." style="width:125px" required="true" /]
	[@b.textarea cols="31" rows="3" label="备注" name="model.remark" maxlength="200" value="${(model.remark)!}" style="font-size:12px" /]
	[@b.radios label='是否启用' name='model.enable' items={"1":"是", "0":"否"} value=(model.enable)!true?string("1", "0") /]
	
	[@b.formfoot]
		[@b.redirectParams /]
		[@b.submit value="${b.text('action.save')}"/]		
		<input type="reset" name="examApplyParamReset" value="${b.text("action.reset")}" />
		<input type="hidden" name="model.id" value="${(model.id)!}" />
		<input type="hidden" name="coderId" value="${(coder.id)!}" />
	[/@]
[/@]
[@b.foot/]