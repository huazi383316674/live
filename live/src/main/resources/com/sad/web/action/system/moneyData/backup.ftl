[#ftl]
[@b.head/]
[@b.toolbar title="数据备份结束"]
	bar.addBack();
[/@]
[@b.messages slash='3'/]

[#if backupMassage??]
	<table width="80%" align="center">
		[#list backupMassage.infos! as info]<tr height="25px"><td><font color="green">${info}</font></td></tr>[/#list]
		[#list backupMassage.errors! as error]<tr height="25px"><td><font color="red">${error}</font></td></tr>[/#list]
	</table>
[/#if]

<script>
	jQuery('div#colorbox').remove();
	jQuery('div#cboxOverlay').remove();
</script>
<script type="text/javascript" src="${base}/static/scripts/colorbox/jquery.colorbox-min.js"></script>
[@b.foot/]