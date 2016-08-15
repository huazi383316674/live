[#ftl]
[@b.head /]

[@b.grid items=models var="model"]
	[@b.gridbar]
		bar.addItem("添加", "add()");
		bar.addItem("修改", "edit()");
		bar.addItem("删除", "remove()");
	[/@]
	[@b.row]
		[@b.boxcol /]
		[@b.col title="代码" property="code" width="20%" /]
		[@b.col title="名称" property="name" width="20%" /]
		[@b.col title="业务类型" property="businessType.name" width="20%"]
			[#if model.businessType.id =1]<font color="green"><b>${model.businessType.name}</b></font>
			[#else]<font color='red'><b>${model.businessType.name}</b></font>[/#if]
		[/@]
		[@b.col title="备注" property="remark" width="20%" /]
		[@b.col title="是否启用" property="enable" width="17%"]
			${(model.enable)?string("<div class='tag submitted'>启用</div>", "<div class='tag unsubmitted'>关闭</div>")!}
		[/@]
	[/@]
[/@]

[@b.form name="modelListForm"]
	<input type="hidden" name="coderId" value="${coder.id}" />
	<input type="hidden" name="params" value="[@htm.queryStr /]" />
[/@]

<script>
	function add() {
		bg.form.submit(document.modelListForm, "moneyBaseCode!edit.action");
	}
	
	function edit() {
		if (!selectedId("model.id", document.modelListForm, "modelId")) return;
		bg.form.submit(document.modelListForm, "moneyBaseCode!edit.action");
	}
	
	function remove() {
		if (!selectedId("model.id", document.modelListForm, "modelId")) return;
		if (!confirm("确定删除?")) return;
		
		bg.form.submit(document.modelListForm, "moneyBaseCode!remove.action");
	}
</script>
[@b.foot /]