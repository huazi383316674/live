[#ftl]
[@b.head /]
[#--[@b.toolbar title="万年历(${Parameters['yearMonth']})" /]--]
<link rel="stylesheet" type="text/css" href="${base}/static/styles/statusStyle.css" />
<script src="${base}/static/scripts/moneyCommon.js"></script>
<script src="${base}/static/scripts/prompt.js"></script> 

[#assign hang = 7 /]
[#if (days + dayOfWeek) % hang != 0] [#assign lie = ((days + dayOfWeek) / hang)?int + 1 /][#else][#assign lie = ((days + dayOfWeek) / hang)?int /][/#if]

[#-- 得到农历 --]
[#function getLunarCalStr day]
	[#list (lunarCalMap?keys)! as day_][#if day?string = day_][#return lunarCalMap[day_] /][/#if][/#list][#return '' /]
[/#function]

<style>
	.formTable td { text-align:center; width:14.2% }
	.infoTable1 { width:100%; height:100% }
	.infoTable1 td { border:0 }
	.in { font-size:11px; color:#008EFD; }
	.inMoney { font-size:14px; color:#008EFD; font-weight:bold; font-family:"Times New Roman",Georgia,Serif; }
	.pay { font-size:11px; color:red; }
	.payMoney { font-size:14px; color:red; font-weight:bold; font-family:"Times New Roman",Georgia,Serif; }
</style>
<table class="formTable" style="width:100%">
	<tr bgcolor="#C7DBFF">
		<td>星期日</td>
		<td>星期一</td>
		<td>星期二</td>
		<td>星期三</td>
		<td>星期四</td>
		<td>星期五</td>
		<td>星期六</td>
	</tr>
	
	[#list 1..lie as l]
	<tr style="height:80px">
		[#list 0..6 as h]
			[#assign day = (l - 1) * 7 + h - dayOfWeek + 1 /]
			<td valign="top" [#if dateNo?? && dateNo=day]bgcolor="#EBEBEB"[#elseif h=0 || h=6]bgcolor="#E1EFF8"[/#if]
				onmouseover="loadIncomePaymentRecords(${day});" onmouseout="closeRecordsDiv()">
				[#assign lunarDay = getLunarCalStr(day) /]
				[#if day > 0 && day <= days]<font size="+1"><b>${day}</b></font></b>&nbsp;<font color='green'>${lunarDay}</font>[/#if]<br/><br/>
				
				[#assign holiday = getHolidays(day, lunarDay) /]
				[#if holiday != '']${holiday}<br>[/#if]
				
				[#assign incomes = getIncomes(day) /] [#assign payments = getPayments(day) /]
				[#if incomes != 0]<sub class="in">收入:</sub><span class="inMoney">${incomes}</span>[/#if]
				[#if payments != 0]<sub class="pay">支出:</sub><span class="payMoney">${payments}</span>[/#if]
			</td>
		[/#list]
	</tr>
	[/#list]
	
</table>
<div id="toolTipLayer" style="position:absolute; visibility: hidden"></div>

[#-- 收支情况 --]
[#function getIncomes day]
	[#assign dayStr = day?string /][#if day?length <2][#assign dayStr ='0' + dayStr /][/#if]
	[#list (incomeMap?keys)! as day_][#if day_ = dayStr][#return incomeMap[day_] /][/#if][/#list][#return 0 /]
[/#function]

[#function getPayments day]
	[#assign dayStr = day?string /][#if day?length <2][#assign dayStr ='0' + dayStr /][/#if]
	[#list (paymentMap?keys)! as day_][#if day_ = dayStr][#return paymentMap[day_] /][/#if][/#list][#return 0 /]
[/#function]

[#-- 节日情况 --]
[#function getHolidays day, lunarDay]
	[#assign hn = '' /]
	[#list holidays! as h]
		[#if h.day?int = day]
			[#if h.holidayType.getEngName() = 'holiday'][#assign hn = hn + "<div class='tag unsubmitted' style='margin:3px'>" + h.name + '</div>' /]
			[#else][#assign hn = hn + "<div class='tag submitted' style='margin:3px'>" + h.name + '('+ h.holidayType.fullName +')</div>' /][/#if]
		[/#if]
	[/#list]
	
	[#list lunarHolidays! as lh]
		[#if lh.lunarDate = lunarDay]
			[#if lh.holidayType.getEngName() = 'holiday'][#assign hn = hn + "<div class='tag unsubmitted' style='margin:3px'>" + lh.name + '</div>' /]
			[#else][#assign hn = hn + "<div class='tag submitted' style='margin:3px'>" + lh.name + '('+ lh.holidayType.fullName +')</div>' /][/#if]
		[/#if]
	[/#list]
	[#return hn /]
[/#function]

<script>
	initToolTips();
	
	function loadIncomePaymentRecords(day) {
		t1 = setTimeout(function () {
			var url = "calendarStatement!loadIncomePaymentRecords.action?yearMonth=${Parameters['yearMonth']}&day=" + day;
			jQuery.get(url, function(data) {
				var dataObj = eval("("+data+")");
				
				var content = "";
				jQuery.each(dataObj.datas, function(idx,item) {
					content += item.name + "&nbsp;&nbsp;" + item.type + "&nbsp;&nbsp;<u>" + item.businessType + "</u>&nbsp;&nbsp;<u>" + item.amount + "</u>";
					if (dataObj.datas.length -1 != idx) { content += "<br>"; }
				})
				
				if (content != "") { toolTip(content, "#000000", "#FFFF00", 250); }
			});
		}, 500);
	}
	
	function closeRecordsDiv() { clearTimeout(t1); toolTip(); }
</script>
[@b.foot /]