[#ftl]
[@b.head /]

[@b.grid items=records var="record" id="inPayGrid"]
	[@b.gridbar]
		bar.addItem("添加", "add()");
		bar.addItem("修改", "edit()");
		bar.addItem("删除", "remove()");
	[/@]
	[@b.row]
		[@b.boxcol /]
		[@b.col title="名称" property="name" width="22%" /]
		[@b.col title="金额" property="amount" width="10%" /]
		[@b.col title="业务类型" property="type.businessType.name" width="10%"]
			[#if record.type.businessType.id =1]<font color="green"><b>${record.type.businessType.name}</b></font>
			[#else]<font color='red'><b>${record.type.businessType.name}</b></font>[/#if]
		[/@]
		[@b.col title="收支类型" property="type.name" width="14%" /]
		[@b.col title="日期" property="createOn" width="14%"]${(record.createOn?string("yyyy-MM-dd"))!}[/@]
		[@b.col title="备注" property="remark" width="27%"][/@]
	[/@]
[/@]

[@b.form name="recordListForm"]
	<input type="hidden" name="params" value="[@htm.queryStr /]" />
[/@]

<script>
	var recordMoneyMap = new Object();
	[#list records! as record]
		recordMoneyMap['${record.id}']=${record.amount?default(0)};		
	[/#list]

	jQuery(function() {
		jQuery('#inPayGrid').click(function() {
			var total = 0;
			for (var i=0; i<document.getElementsByName("record.id").length; i++) {
				if (document.getElementsByName("record.id")[i].checked) {
					total = accAdd(recordMoneyMap[document.getElementsByName("record.id")[i].value], total);
				}
			}
			if (total != 0) { jQuery("#totalMoneySpan").html(" 共计:" + total + "&nbsp;"); }
			else { jQuery("#totalMoneySpan").html(""); }
		})
	})
	
	function add() { bg.form.submit(document.recordListForm, "incomePaymentRecord!edit.action"); }
	
	function edit() {
		if (!selectedId("record.id", document.recordListForm, "recordId")) return;
		bg.form.submit(document.recordListForm, "incomePaymentRecord!edit.action");
	}
	
	function remove() {
		if (!selectedIds("record.id", document.recordListForm, "recordIds")) return;
		if (confirm("确定删除吗?")) { bg.form.submit(document.recordListForm, "incomePaymentRecord!remove.action"); }
	}
	
	function accAdd(arg1, arg2) {
		var r1, r2, m, c;
		try { r1 = arg1.toString().split(".")[1].length } catch (e) { r1 = 0 }
		try { r2 = arg2.toString().split(".")[1].length } catch (e) { r2 = 0 }
		c=Math.abs(r1 - r2);
        m=Math.pow(10, Math.max(r1, r2));
        if(c>0){
			var cm = Math.pow(10, c);
			if (r1 > r2) {
				arg1 = Number(arg1.toString().replace(".", ""));
                arg2 = Number(arg2.toString().replace(".", "")) * cm;
			} else {
				arg1 = Number(arg1.toString().replace(".", "")) * cm;
				arg2 = Number(arg2.toString().replace(".", ""));
			}
		} else {
			arg1 = Number(arg1.toString().replace(".", ""));
			arg2 = Number(arg2.toString().replace(".", ""));
		}
        return (arg1 + arg2) / m
	}
</script>
[@b.foot /]