[#ftl]
[@b.head/]
[@b.toolbar title="数据备份"]
	bar.addBlankItem();
[/@]

[#function getConfigItem name_]
	[#list configItems! as item][#if item.name=name_][#return item /][/#if][/#list][#return "" /]
[/#function]

<table width="100%" style="font-size:14px">
	<tr height="23px">
		<td align="center">备份须知</td>
	</tr>
	<tr height="23px">
		<td>请检查以下参数是否已配置及配置是否正确:</td>
	</tr>
	<tr height="23px">
		<td style="font-size:12px">（如配置有误，请在“系统设置” — “系统状态” — “系统设置”中，进行配置参数）</td>
	</tr>
	<tr>
		<td>
			<table class="formTable" width="100%">
				<tr bgcolor="#C7DBFF" height="23px">
					<td>参数名</td>
					<td>参数值</td>
					<td>说明</td>
				</tr>
				[#list configParams! as configParam]
				<tr height="23px">
					<td>${configParam}</td>
					[#assign item = getConfigItem(configParam) /]
					[#if item != ""]
						<td>${(item.value)!}</td>
						<td>${(item.description)!}</td>
					[#else]
						<td colspan="2"><font color="red">还没有设置该参数</font></td>
					[/#if]
				</tr>
				[/#list]
			</table>
		</td>
	</tr>
	<tr>
		<td align="center"><input type="button" onclick="backupDatas()" value=" 开始备份 " style="height:50px; width:100px"/></td>
	</tr>
</table>
[@b.form name="backUpDatasForm" action="!backup"][/@]

<div style="display:none">
	<div id="importWaitDiv" style="text-align:center;">
		<br/><br/><img src="${base}/static/images/loading.gif" /><br/><br/>正在进行备份，请等候...</span>
	</div>
</div>

<script>
	jQuery('div#colorbox').remove();
	jQuery('div#cboxOverlay').remove();
</script>
<script type="text/javascript" src="${base}/static/scripts/colorbox/jquery.colorbox-min.js"></script>
<script>
	function backupDatas() {
		if (!confirm("确定开始备份?")) return;
		bg.form.submit(document.backUpDatasForm);
		jQuery.colorbox({transition:'none', title:"请等候...", overlayClose:false, width:"360px", height:"200px", inline:true, href:"#importWaitDiv"});
	}
</script>
[@b.foot/]