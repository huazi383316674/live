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
		[@b.col title="名称" property="name" width="30%" /]
		[@b.col title="备注" property="remark" width="27%" /]
		[@b.col title="是否启用" property="enable" width="20%"]
			${(model.enable)?string("<div class='tag accepted'>启用</div>", "<div class='tag rejected'>关闭</div>")!}
		[/@]
	[/@]
[/@]

[@b.form name="modelListForm"]
	<input type="hidden" name="coderId" value="${coder.id}" />
	<input type="hidden" name="params" value="[@htm.queryStr /]" />
[/@]

<script>
	function add() { bg.form.submit(document.modelListForm, "moneyBaseCode!edit.action"); }
	
	function edit() {
		if (!selectedId("model.id", document.modelListForm, "modelId")) return;
		bg.form.submit(document.modelListForm, "moneyBaseCode!edit.action");
	}
	
	function remove() {
		if (!selectedIds("model.id", document.modelListForm, "modelIds")) return;
		bg.form.submit(document.modelListForm, "moneyBaseCode!remove.action");
	}
</script>
[@b.foot /]