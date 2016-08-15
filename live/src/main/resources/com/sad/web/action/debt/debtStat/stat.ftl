[#ftl]
[@b.head/]
[@b.toolbar title="债务统计报表"]
	bar.addBack();
[/@]
<link rel="stylesheet" type="text/css" href="${base}/static/styles/statusStyle.css" />

<style>
	.formTable td { text-align: center; height: 28px }
	.trHead { background-color: #C7DBFF; font-weight: bold }
</style>

<table class="formTable" style="width:100%">
	<tr class="trHead">
		<td width="16%">债务人</td>
		<td width="17%">债务类型</td>
		<td width="17%">债务金额</td>
		<td width="17%">已归还金额</td>
		<td width="17%">未归还金额</td>
		<td width="16%">是否已归还</td>
	</tr>
	[#assign debtTotal = 0/]
	[#assign reDebtTotal = 0/]
	[#assign lastTotal = 0/]
	
	[#list debts! as debt]
	<tr [#if debt_index%2=0]bgcolor="white"[#else]bgcolor="#EBEBEB"[/#if]>
		<td>${debt[0]}</td>
		<td>${debt[1].fullName}</td>
		<td>[#assign debtCount = debt[2]?default(0) /]${debtCount}
			[#assign debtTotal = debtTotal + debtCount /]
		</td>
		<td>
			[#assign reDebtCount = debt[3]?default(0) /]${reDebtCount}
			[#assign reDebtTotal = reDebtTotal + reDebtCount /]
		</td>
		<td>
			[#assign lastCount = debtCount - reDebtCount /]
			[#if lastCount &gt; 0]<div class='tag unsubmitted'>${lastCount}</div>
			[#else]${lastCount}[/#if]
			
			[#assign lastTotal = lastTotal + lastCount /]
		</td>
		<td>[#if debtCount &gt; reDebtCount]<div class='tag rejected'>否</div>[#else]<div class='tag accepted'>是</div>[/#if]</td>
	</tr>
	[/#list]
	<tr class="trHead">
		<td colspan="2">合计</td>
		<td style="font-weight: normal">${debtTotal}</td>
		<td style="font-weight: normal">${reDebtTotal}</td>
		<td>${lastTotal}</td>
		<td></td>
	</tr>
</table>