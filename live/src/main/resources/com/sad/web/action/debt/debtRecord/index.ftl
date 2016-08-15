[#ftl]
[@b.head/]
[@b.toolbar title="债务清单管理"]
	bar.addItem("报表统计", "debtStat()");
[/@]
<script src="${base}/static/scripts/moneyCommon.js"></script>
<link rel="stylesheet" type="text/css" href="${base}/static/styles/statusStyle.css" />

<table class="indexpanel">
	<tr>
		<td class="index_view" style="width:18%">
			[@b.form name="deptRecordSearchForm" action="!search" title="ui.searchForm" target="contentDiv" theme="search"]
				[#include "searchForm.ftl" /]	
			[/@]
	   	</td>
		<td class="index_content">
			[@b.div id="contentDiv" /]
		</td>
	</tr>
</table>

<script>
	jQuery(function(){
		bg.form.submit(document.deptRecordSearchForm);
		
		jQuery("#record\\.businessTypeId").change(function() {
			var selectId = "record\\.recordTypeId";
			var url = "incomePaymentRecord!getIncomePaymentTypes.action?businessTypeId=" + jQuery("#record\\.businessTypeId").val();
			
			jQuery("#" + selectId).find("option").remove();
			jQuery("#" + selectId).append("<option value=''>...</option>");	
			
			jQuery.get(url, function(data) {
				var dataObj = eval("("+data+")");
				jQuery.each(dataObj.datas, function(idx,item) {
					if ('${(record.type.id)!}' == item.id) { 
						jQuery("#" + selectId).append("<option value="+item.id+" selected=selected>"+item.name+"</option>");
					} else { jQuery("#" + selectId).append("<option value="+item.id+">"+item.name+"</option>"); }	
				})
			})
		})
	})
	
	function debtStat() {
		bg.Go("debtStat!stat.action", "contentDiv");
	}
</script>
[@b.foot/]