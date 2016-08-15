[#ftl]
[@b.head /]

[@b.grid items=debtRecords var="debtRecord"]
	[@b.gridbar]
		bar.addItem("添加", "add()");
		bar.addItem("修改", "edit()");
		bar.addItem("删除", "remove()");
		bar.addItem("归还", "debtReturns()");
	[/@]
	[@b.row]
		[@b.boxcol /]
		[@b.col title="债务名称" property="name" width="13%"]
			[#if debtRecord.finished]<s>&nbsp;${debtRecord.name}&nbsp;</s>[#else]${debtRecord.name}[/#if]
		[/@]
		[@b.col title="债务人" property="debtUserName" width="12%" /]
		[@b.col title="金额" property="amount" width="8%" /]
		[@b.col title="债务类型" width="10%"]
			[#if debtRecord.debtType = 'borrowIn']<font color="green"><b>借入</b></font>
			[#else]<font color='red'><b>借出</b></font>[/#if]
		[/@]
		[@b.col title="债务产生日期" property="createOn" width="10%"]${(debtRecord.createOn?string("yyyy-MM-dd"))!}[/@]
		[@b.col title="债务预归还日期" property="preReturnOn" width="12%"]${(debtRecord.preReturnOn?string("yyyy-MM-dd"))!}[/@]
		[@b.col title="债务归还日期" property="returnOn" width="10%" /]
		[@b.col title="是否已归还" property="finished" width="10%"]
			<b>${(debtRecord.finished?string("<font color='green'>是</font>", "<font color='red'>否</font>"))!}</b>
		[/@]
		[@b.col title="备注" property="remark" width="12%"][/@]
	[/@]
[/@]

[@b.form name="debtRecordListForm"]
	<input type="hidden" name="params" value="[@htm.queryStr /]" />
[/@]

<script>
	function add() {
		bg.form.submit(document.debtRecordListForm, "debtRecord!edit.action");
	}
	
	function edit() {
		if (!selectedId("debtRecord.id", document.debtRecordListForm, "debtRecordId")) return;
		bg.form.submit(document.debtRecordListForm, "debtRecord!edit.action");
	}
	
	function remove() {
		if (!selectedIds("debtRecord.id", document.debtRecordListForm, "debtRecordIds")) return;
		if (confirm("确定删除吗?")) {
			bg.form.submit(document.debtRecordListForm, "debtRecord!remove.action");
		}
	}
	
	function debtReturns() {
		if (!selectedId("debtRecord.id", document.debtRecordListForm, "debtRecordId")) return;
		bg.form.submit(document.debtRecordListForm, "debtReturn!search.action");
	}
</script>
[@b.foot /]