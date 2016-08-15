[#ftl]
[@b.head /]
[@b.toolbar title="基础代码维护" /]
<link rel="stylesheet" type="text/css" href="${base}/static/styles/statusStyle.css" />
<script src="${base}/static/scripts/moneyCommon.js"></script>

<table class="indexpanel">
	<tr>
		<td class="index_view">
			[@b.form name="baseCoderSearchForm" action="!search" title="ui.searchForm" target="contentDiv" theme="search"]
				[@b.field label="基础代码"]<select name="coderId">
				     	[#list baseCoders! as coder]
				     	<option value=${(coder.id)!}>${(coder.name)!}</option>
				     	[/#list]
				    </select>
				[/@]
			[/@]
	   	</td>
		<td class="index_content">
			[@b.div id="contentDiv" /]
		</td>
	</tr>
</table>

<script>
	jQuery(function(){
		bg.form.submit(document.baseCoderSearchForm);
	})
</script>
[@b.foot/]