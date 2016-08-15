[#ftl]
[@b.head/]
[@b.toolbar title="添加/修改意见信息"]
	bar.addBack();
[/@]
<link rel="stylesheet" href="${base}/static/scripts/chosen/chosen.css" />
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/chosen/chosen.jquery.js?v=1"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/chosen/ajax-chosen.js?v=1"></script>

[@b.form name="shoppingGoodsEditForm" action="!save" title="" theme="list"]
	[@b.textfield name="suggest.firstModule" label="一级模块" value="${(suggest.firstModule)!}" maxlength="50" required="true" style="width:150px" /]
	[@b.textfield name="suggest.secondModule" label="二级模块" value="${(suggest.secondModule)!}" maxlength="100" required="true" style="width:150px" /]
	[@b.select label="指派给" name="suggest.appointUser.id" id="appointUserId" style="width:155px" /]
	[@b.textarea cols="70" rows="4" label="问题描述" name="suggest.content" maxlength="500" value="${(suggest.content)!}" required="true" comment="不超过500字"/]
	[@b.textarea cols="70" rows="4" label="备注" name="suggest.remark" maxlength="500" value="${(suggest.remark)!}" comment="不超过500字"/]
	[@b.formfoot]
		[@b.redirectParams/]
		[@b.submit value="${b.text('action.save')}"/]		
		<input type="reset" value="${b.text("action.reset")}" />
		<input type="hidden" name="suggest.id" value="${(suggest.id)!}" />
	[/@]
[/@]

<script language="javascript">
	function save() {
		var form = document.electParamsForm;
		if (form["courseTake.stdId"].value == "") {
			alert("学生学号为空!"); return;
		} else if (form["courseIds"].value == "") {
			alert("课程代码为空!"); return;
		}
		bg.form.submit(form);
	}
	
	jQuery(function() {
		jQuery("#appointUserId").ajaxChosen(
			{
				method: 'GET',
				url: 'suggest!searchUserByNameOrFullname.action?pageNo=1&pageSize=20'
			}
			, function (data) {
				var items = {};
				var dataObj = eval("(" + data + ")");
				jQuery.each(dataObj.datas, function (i, user) {
					items[user.id] = user.name + " (" + user.fullname + ")";
				});
				return items;
			}
		);
	});
</script>
[@b.foot/]