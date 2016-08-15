[#ftl]
[@b.head/]
[@b.toolbar title="用户意见"]
	bar.addBlankItem();
[/@]

<table class="indexpanel">
	<tr>
		<td class="index_view" style="width:190px">
		[@b.form name="suggestSearchForm" action="!search" title="ui.searchForm" target="contentDiv" theme="search"]
			[#include "searchForm.ftl" /]
		[/@]
	   	</td>
		<td class="index_content">
			[@b.div id="contentDiv" /]
		</td>
	</tr>
</table>

<script>
	jQuery(function() {
		bg.form.submit(document.suggestSearchForm);
	})
</script>
[@b.foot/]