[#ftl]
[@b.head/]
[@b.toolbar title="意见详情"]
	bar.addItem("跟踪处理", "suggestTail()");
	bar.addBack();
[/@]
<link rel="stylesheet" href="${base}/static/scripts/chosen/chosen.css" />
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/chosen/chosen.jquery.js?v=1"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/chosen/ajax-chosen.js?v=1"></script>
<style>
	.infoTable tr { height:26px }
	.titleTr { font-weight:bold;text-align:center;background-color:#c7dbff; }
</style>

<table width="100%" class="infoTable">
	<tr>
		<td colspan="6" class="titleTr">意见内容</td>
	</tr>
	<tr>
		<td class="title" style="width:15%">编号：</td>
		<td style="width:15%">${(suggest.no)!}</td>
		<td class="title" style="width:15%">提出人：</td>
		<td style="width:15%">${(suggest.speaker.fullname)!}</td>
		<td class="title" style="width:15%">所属科室：</td>
		<td>${(suggest.speaker.department.name)!}</td>
	</tr>
	<tr>
		<td class="title">一级模块：</td>
		<td>${(suggest.firstModule)!}</td>
		<td class="title">二级模块：</td>
		<td>${(suggest.secondModule)!}</td>
		<td class="title">提出时间：</td>
		<td>${(suggest.createdAt?string("yyyy-MM-dd HH:mm"))!}
			[#if suggest.predictHandleAt??][<span title="预修复日期" style="color:blue">${(suggest.predictHandleAt?string("yyyy-MM-dd"))!}</span>][/#if]</td>
	</tr>
	<tr>
		<td class="title">指派给：</td>
		<td>${(suggest.appointUser.fullname)!}</td>
		<td class="title">处理状态：</td>
		<td>[#if suggest.handleType.id = 1]<font color="red">${(suggest.handleType.name)!}</font>
			[#elseif suggest.handleType.id = 2]<font color="green">${(suggest.handleType.name)!}</font>
			[#else]<font color="blue">${(suggest.handleType.name)!}</font>[/#if]
		</td>
		<td class="title">最后修改时间：</td>
		<td>${(suggest.updatedAt?string("yyyy-MM-dd HH:mm"))!}</td>
	</tr>
	<tr>
		<td class="title">问题描述：</td>
		<td colspan="5" style="line-height:18px">${(suggest.content)!}</td>
	</tr>
	<tr>
		<td class="title">备注：</td>
		<td colspan="5" style="line-height:18px">${(suggest.remark)!}</td>
	</tr>
	<tr>
		<td class="title">是否通过：</td>
		<td colspan="5">${(suggest.passed?string("是", "否"))!}</td>
	</tr>
</table>

<table width="100%" class="infoTable">
	<tr>
		<td colspan="6" class="titleTr">跟踪记录</td>
	</tr>
	[#list suggest.suggestTails! as tail]
	<tr>
		<td class="title" style="width:15%">处理状态：</td>
		<td style="width:15%">${(tail.handleType.name)!}</td>
		<td class="title" style="width:15%">指派给：</td>
		<td style="width:15%">${(tail.appointUser.fullname)!}</td>
		<td class="title" style="width:15%">跟踪人：</td>
		<td><b>${(tail.tailUser.fullname)!}</b>&nbsp;&nbsp;${(tail.createdAt?string("yyyy-MM-dd HH:mm"))!}</td>
	</tr>
	<tr>
		<td class="title">说明：</td>
		<td colspan="5">${(tail.tailExplain)!}</td>
	</tr>
	[#if tail_has_next]<tr><td colspan="5"></td></tr>[/#if]
	[/#list]
</table>


<div style="display:none">
	<div id="suggestTailDiv">
		[@b.form name="assignForm" action="!addSuggestTail" target="contentDiv"]
		<table width="100%">
			<tr>
				<td width="30%" height="30px" align="right"><font color="red">*</font>处理状态:</td>
				<td><select id="handleTypeId" name="handleTypeId" style="width:150px">
						[#list handleTypes! as handleType]
							<option value="${handleType.id}" [#if handleType.id=suggest.handleType.id]selected=selected[/#if]>${handleType.name}</option>
						[/#list]
					</select></td>
			</tr>
			<tr>
				<td height="30px" align="right"><font color="red">*</font>指派给:</td>
				<td>
					<select id="appointUserId" name="appointUserId" style="width:150px">
						<option value="${suggest.speaker.id}">${(suggest.speaker.fullname)!}<option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="right">说明:</td>
				<td><textArea cols="40" rows="3" name="tailExplain"></textArea></td>
			</tr>
			<tr>
				<td colspan="2" align="center" height="40px">
					<input type="button" value=" 保存 " onclick="addSuggestTail();" />
					<input type="button" value=" 关闭 " onclick="jQuery.colorbox.close();" />
					<input type="hidden" value="[@htm.queryStr /]" name="params" />
					<input type="hidden" value="${suggest.id}" name="suggest.id" />
					
				</td>
			</tr>
		</table>
		[/@]
	</div>
</div>

<script>
	jQuery('div#colorbox').remove();
	jQuery('div#cboxOverlay').remove();
</script>
<script type="text/javascript" src="static/scripts/colorbox/jquery.colorbox-min.js"></script>
<script>
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
	
	function suggestTail() {
		jQuery.colorbox({transition:'none', title:"跟踪处理", overlayClose:false, width:"550px", height:"300px", inline:true, href:"#suggestTailDiv"});
	}
	
	function addSuggestTail() {
		if (jQuery("#handleTypeId").val() == "${suggest.handleType.id}") {
			if (!confirm("您跟踪的处理状态与该意见状态一致，确定要提交?")) return;
		}
		bg.form.submit(document.assignForm);
	}
</script>