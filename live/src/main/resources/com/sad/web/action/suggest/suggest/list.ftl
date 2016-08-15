[#ftl]
[@b.head/]
[@b.toolbar title="意见列表" /]
<link rel="stylesheet" href="${base}/static/scripts/chosen/chosen.css" />
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/chosen/chosen.jquery.js?v=1"></script>
<script language="JavaScript" type="text/JavaScript" src="${base}/static/scripts/chosen/ajax-chosen.js?v=1"></script>

[@b.grid items=suggests var="suggest"]
	[@b.gridbar]
		bar.addItem("${b.text('action.add')}", action.add());
		bar.addItem("${b.text('action.edit')}", action.edit());
		bar.addItem("${b.text('action.delete')}", action.remove());
		bar.addItem("${b.text('action.info')}", action.info());
		bar.addItem("指派", "assign()");
	[/@]
	[@b.row]
		[@b.boxcol/]
		[@b.col title="编号" property="no" width="5%"]
			[@b.a href='!info?suggest.id=${suggest.id}' title='查看意见详细信息']${(suggest.no)!}[/@]
		[/@]
		[@b.col title="提出人" property="speaker.fullname" width="7%"][/@]
		[@b.col title="所属科室" property="speaker.department.name" width="8%"][/@]
		[@b.col title="一级模块" property="firstModule" width="9%"][/@]
		[@b.col title="二级模块" property="secondModule" width="9%"][/@]
		[@b.col title="问题描述" property="content"]
			[#assign content= (suggest.content?replace('\"', "'"))! /]<span title="${content}">
        	[#if content?length &gt; 30]${content[0..30]}...[#else]${content}[/#if]</span>
		[/@]
		[@b.col title="提出日期" property="createdAt" width="8%"]${(suggest.createdAt?string("yyyy-MM-dd"))!}[/@]
		[@b.col title="指派给" property="appointUser.fullname" width="8%"/]
		[@b.col title="预修复日期" property="predictHandleAt" width="8%"]${(suggest.predictHandleAt?string("yyyy-MM-dd"))!}[/@]
		[@b.col title="处理情况" property="handleType.name" width="7%"]
			<b>[#if suggest.handleType.id = 1]<font color="red">${(suggest.handleType.name)!}</font>
			[#elseif suggest.handleType.id = 2]<font color="green">${(suggest.handleType.name)!}</font>
			[#else]<font color="blue">${(suggest.handleType.name)!}</font>[/#if]</b>
		[/@]
		[@b.col title="是否通过" property="passed" width="7%" /]
	[/@]
[/@]

<div style="display:none">
	<div id="assignDiv">
		[@b.form name="assignForm" action="!assign" target="contentDiv"]
		<table width="100%">
			<tr>
				<td width="40%" height="40px" align="right">指派给:</td>
				<td><select id="appointUserId" name="appointUserId" style="width:150px">
						<option value="">...<option>
					</select></td>
			</tr>
			<tr>
				<td height="30px" align="right" height="40px">预期修复日期:</td>
				<td>[@b.datepicker name="predictHandleAt" value="" style="width:150px" format="yyyy-MM-dd" /]</td>
			</tr>
			<tr>
				<td colspan="2" align="center" height="40px">
					<input type="button" value=" 保存 " onclick="doAssign();" />
					<input type="button" value=" 关闭 " onclick="jQuery.colorbox.close();" />
					<input type="hidden" value="[@htm.queryStr /]" name="params" />
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
<script language="javascript">
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
	
	function assign() {
		var suggestIds = bg.input.getCheckBoxValues("suggest.id");
		if (suggestIds == "") {	alert("请选择记录进行操作!"); return; }
		jQuery.colorbox({transition:'none', title:"指派给..", overlayClose:false, width:"450px", height:"240px", inline:true, href:"#assignDiv"});
	}
	
	function doAssign() {
		[#--if (jQuery("#appointUserId").val() == "") { alert("请选择需要指派的人员!"); return; }--]
		bg.form.addInput(document.assignForm, "suggestIds", bg.input.getCheckBoxValues("suggest.id"));
		bg.form.submit(document.assignForm);
	}
</script>
[@b.foot/]