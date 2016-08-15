[#ftl]
[@b.head/]
<link rel="stylesheet" type="text/css" href="${base}/static/styles/statusStyle.css" />
<script src="${base}/static/scripts/moneyCommon.js"></script>

[#function getAmount userId]
	[#list (amountMap?keys)! as userId_][#if userId?string = userId_][#return amountMap[userId_] /][/#if][/#list][#return 0 /]
[/#function]

[@b.grid items=commonUsers var="commonUser"]
	[@b.gridbar]
		bar.addItem("${b.text('action.add')}", action.add());
		bar.addItem("${b.text('action.edit')}", action.edit());
		bar.addItem("${b.text('action.delete')}", action.remove());
		bar.addItem("启用", "isOpen(1)", "${b.theme.iconurl('actions/activate.png')}");
		bar.addItem("禁用", "isOpen(0)", "${b.theme.iconurl('actions/freeze.png')}");
	[/@]
	[@b.row]
		[@b.boxcol/]
		[@b.col title="姓名" property="name" style="width:25%" /]
		[@b.col title="创建日期" property="createOn" style="width:25%"]${(commonUser.createOn?string('yyyy-MM-dd'))!}[/@]
		[@b.col title="是否启用" property="enable" style="width:25%"]
			${(commonUser.enable?string("<div class='tag submitted'>是</div>", "<div class='tag unsubmitted'>否</div>"))!}
		[/@]
		[@b.col title="余额" style="width:25%"]
			[#assign amount = getAmount(commonUser.id) /]
			<b>[#if amount &gt;= 0]<font color="green" size="+1">${amount}</font>[#else]<font color="red" size="+1">${amount}</font>[/#if]</b>
		[/@]
	[/@]
[/@]

[@b.form name="commonUserListForm"]
	<input type="hidden" name="params" value="[@htm.queryStr /]" />
[/@]
<script>
	function isOpen(isOpen) {
		if (!selectedIds("commonUser.id", document.commonUserListForm, "commonUserIds")) return;
		
		bg.form.addInput(document.commonUserListForm, "isOpen", isOpen);
		bg.form.submit(document.commonUserListForm, "commonUser!isOpen.action");
	}
</script>
[@b.foot/]