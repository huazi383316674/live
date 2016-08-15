[#ftl]
[@b.head/]
	[@b.toolbar title="公共用户管理"]
	[/@]
	<table class="indexpanel">
		<tr>
			<td class="index_view">
			[@b.form name="commonUserSearchForm" action="!search" title="ui.searchForm" target="contentDiv" theme="search"]
				[@b.textfield name="commonUser.name" label="用户姓名" /]
				[@b.select items={'1':'是','0':'否'} label='是否启用' empty="..." name="commonUser.enable"/]
			[/@]
		   	</td>
			<td class="index_content">
				[@b.div id="contentDiv" href="!search" /]
			</td>
		</tr>
	</table>
[@b.foot/]