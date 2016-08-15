[#ftl]
[@b.head/]
[@b.toolbar title="添加/更新公共用户"]
	bar.addBack();
[/@]
[@b.form name="commonUserEditForm" action="!save" title="" theme="list"]
	[@b.textfield name="commonUser.name" label="用户姓名" value="${(commonUser.name)!}" maxlength="200" required="true" style="width:150px" /]
	[@b.datepicker readOnly="readOnly" label="创建时间" required="true" name="commonUser.createOn" value="${(commonUser.createOn?string('yyyy-MM-dd'))!}" style="width:150px"  format="yyyy-MM-dd" /]
	[@b.radios label='是否启用' name='commonUser.enable' items={"1":"是", "0":"否"} value=(commonUser.enable)!true?string("1", "0") /]
	[@b.formfoot]
		<input type="hidden" name="commonUser.id" value="${(commonUser.id)!}" />
		[@b.redirectParams/]
		[@b.submit value="${b.text('action.save')}"/]		
		<input type="reset" name="examApplyParamReset" value="${b.text("action.reset")}" />
	[/@]
[/@]
[@b.foot/]