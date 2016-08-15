[#ftl]
[@b.head/]
	[@b.toolbar title="节日提醒"]
		bar.addBlankItem();
	[/@]
	<table class="indexpanel">
		<tr>
			<td class="index_view">
			[@b.form name="holidaySearchForm" action="!search" title="ui.searchForm" target="contentDiv" theme="search"]
				[@b.textfield name="holidayRemind.name" label="名称" /]
				[@b.select items={"birthday":"生日", "memorialDay":"纪念日"} label='节日类型' empty="..." name="holidayType"/]
			[/@]
		   	</td>
			<td class="index_content">
				[@b.div id="contentDiv" href="!search" /]
			</td>
		</tr>
	</table>
[@b.foot/]