[#ftl]
[@b.head/]
<link rel="stylesheet" type="text/css" href="${base}/static/styles/statusStyle.css" />

[@b.form name="consumeSearchForm" action="!consumes"]
	[@b.grid items=consumes var="consume" filterable="true"]
		[@b.gridbar]
			bar.addItem("${b.text('action.add')}",action.add());
			bar.addItem("${b.text('action.edit')}",action.edit());
			bar.addItem("${b.text('action.delete')}",action.remove());
		[/@]
		
		[@b.gridfilter property="createOn"]
	    	[@b.datepicker name="consume.createOn" value="${(Parameters['consume.createOn'])!}" format="yyyy-MM-dd" /]
		[/@]
		
		[@b.row]
			[@b.boxcol/]
			[@b.col title="日期" property="createOn" width="16%" /]
			[@b.col title="姓名" property="commonUser.name" width="16%" /]
			[@b.col title="类型" property="businessType.id" width="16%"]
				[#if consume.businessType.id =1]<div class='tag accepted'>充值</div>
				[#else]<div class='tag rejected'>消费</div>[/#if]
			[/@]
			[@b.col title="金额" property="amount" width="15%" /]
			[@b.col title="备注" property="remark" width="37%" /]
		[/@]
	[/@] 
[/@]
[@b.foot/]