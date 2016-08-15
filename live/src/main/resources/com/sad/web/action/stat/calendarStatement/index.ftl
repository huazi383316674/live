[#ftl]
[@b.head/]
[@b.toolbar title="日历报表" /]
<table class="indexpanel">
	<tr>
		<td class="index_view">
			<div style="background: url('${base}/static/images/semesterBarBg.png') repeat-x scroll 50% 50% #DEEDF7;border: 1px solid #AED0EA;color: #222222;height:28px;">
				[@b.form name="calendarSearchForm" action="!search" target="contentDiv"]
					[@b.datepicker label="年月" name="yearMonth" style="width:125px"  format="yyyy-MM" value="${(nowDate?string('yyyy-MM'))!}" /]
					<input type="button" value=" 查询 " onclick="search()" />
				[/@]
			</div>
	   	</td>
	</tr>
	<tr>
		<td class="index_content">
			[@b.div id="contentDiv" /]
		</td>
	</tr>
</table>

<script>
	jQuery(function(){
		search();
	})
	
	function search() {
		bg.form.submit(document.calendarSearchForm);
	}
</script>
[@b.foot/]