[#ftl]
[@b.head/]
[@b.toolbar title="添加/更新节日提醒"]
	bar.addBack();
[/@]
[@b.form name="holidayEditForm" action="!save" title="" theme="list"]
	[@b.textfield name="holidayRemind.name" label="名称" value="${(holidayRemind.name)!}" maxlength="200" required="true" style="width:150px" /]
	[@b.select label="节日类型" name="holidayType" items={"birthday":"生日", "memorialDay":"纪念日"} value=(holidayRemind.holidayType.name)! required="true" style="width:155px" /]
	[@b.datepicker readOnly="true" label="日期" required="true" name="holidayDate" value="${(holidayDate?string('yyyy-MM-dd'))!}" style="width:150px" format="yyyy-MM-dd" comment="${(holidayRemind.lunarDate)!}" /]
	[@b.radios label='是否农历' name='holidayRemind.lunar' items={"1":"是", "0":"否"} value=(holidayRemind.lunar)!false?string("1", "0") /]
	[@b.formfoot]
		[@b.redirectParams/]
		[@b.submit value="${b.text('action.save')}"/]		
		<input type="reset" value="${b.text("action.reset")}" />
		<input type="hidden" name="holidayRemind.id" value="${(holidayRemind.id)!}" />
	[/@]
[/@]
[@b.foot/]