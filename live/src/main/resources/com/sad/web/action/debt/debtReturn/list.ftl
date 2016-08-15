[#ftl]
[@b.head /]
[@b.toolbar title="债务归历史记录  (${debtRecord.name}-￥${debtRecord.amount}-${(debtRecord.debtUserName)})"]
	bar.addBack();
[/@]

[@b.grid items=debtReturnRecords var="debtReturnRecord"]
	[@b.gridbar]
		bar.addItem("添加", "addReturnRecord()");
		bar.addItem("删除", "removeReturnRecord()");
	[/@]
	[@b.row]
		[@b.boxcol /]
		[@b.col title="债务名称" property="debtRecord.name" width="16%" /]
		[@b.col title="债务人" property="debtRecord.debtUserName" width="16%" /]
		[@b.col title="债务预归还日期" property="debtRecord.preReturnOn" width="17%"]${(rebtRecord.preReturnOn?string("yyyy-MM-dd"))!}[/@]
		[@b.col title="归还金额" property="amount" width="16%" /]
		[@b.col title="归还日期" property="returnOn" width="16%"]${(rebtRecord.returnOn?string("yyyy-MM-dd"))!}[/@]
		[@b.col title="备注" property="remark" width="16%"][/@]
	[/@]
[/@]

[@b.form name="deptReturnListForm" target="contentDiv"]
	<input name="debtRecordId" value="${debtRecord.id}" type="hidden" />
[/@]

<script>
	function addReturnRecord() {
		bg.form.submit(document.deptReturnListForm, "debtReturn!edit.action");
	}
	
	function removeReturnRecord() {
		if (!selectedIds("debtReturnRecord.id", document.deptReturnListForm, "debtReturnRecordIds")) return;
		
		if (confirm("确定删除吗?")) {
			bg.form.submit(document.deptReturnListForm, "debtReturn!remove.action");
		}
	}
</script>
[@b.foot/]