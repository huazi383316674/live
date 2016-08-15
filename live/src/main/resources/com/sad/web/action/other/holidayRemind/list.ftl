[#ftl]
[@b.head/]

[@b.grid items=holidayReminds var="holidayRemind"]
	[@b.gridbar]
		bar.addItem("${b.text('action.add')}",action.add());
		bar.addItem("${b.text('action.edit')}",action.edit());
		bar.addItem("${b.text('action.delete')}",action.remove());
	[/@]
	[@b.row]
		[@b.boxcol/]
		[@b.col title="名称" property="name" style="width:15%" /]
		[@b.col title="节日类型" style="width:15%"]${(holidayRemind.holidayType.fullName)!}[/@]
		[@b.col title="年份" property="year" style="width:15%" /]
		[@b.col title="月" property="month" style="width:15%"/]
		[@b.col title="日" property="day" style="width:15%"/]
		[@b.col title="是否农历" property="lunar" style="width:7%"]${(holidayRemind.lunar?string('是', '否'))!}[/@]
		[@b.col title="农历日期" style="width:15%"]${(holidayRemind.lunarDate)!}[/@]
	[/@]
[/@]
[@b.foot/]