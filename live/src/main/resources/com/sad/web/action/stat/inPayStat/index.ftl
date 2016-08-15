[#ftl/]
[@b.head /]
[@b.toolbar title="收支统计" /]

<style>
	.transfer{PADDING-LEFT:3px;PADDING-RIGHT:3px;BACKGROUND-COLOR:#e9f2f8;BORDER:1px solid #336699;cursor:pointer;font-Weight:bold}
	.padding{PADDING-LEFT:4px;PADDING-RIGHT:4px;PADDING-TOP:2px;PADDING-BOTTOM:2px;cursor:pointer;}
</style>
<script type="text/javascript" src="${base}/static/scripts/raphael/raphael-min.js"></script>
<script type="text/javascript" src="${base}/static/scripts/raphael/g.raphael-min.js"></script>
<script type="text/javascript" src="${base}/static/scripts/raphael/g.line-min.js"></script>
<script type="text/javascript" src="${base}/static/scripts/raphael/g.pie-min.js"></script>

<div style="background: url('${base}/static/images/semesterBarBg.png') repeat-x scroll 50% 50% #DEEDF7;border: 1px solid #AED0EA;color: #222222;height:34px;">
<form name="moneyStatForm" method="post">
<table>
	<tr height="30px">
		<td id="view0" class="padding" onclick="javascript:statView(0, 'stat_type')" width="120px" >
			<font color="blue">&nbsp;每月收支比例</font>
       	</td>
       	<td id="view1" class="padding" onclick="javascript:statView(1, 'index_annotate')" width="120px">
          	<font color="blue">&nbsp;每月收支幅度</font>
       	</td>
       	<td id="view2" class="padding" onclick="javascript:statView(2, 'stat_businessType')" width="120px">
			<font color="blue">&nbsp;按业务类型统计</font>
       	</td>
       	<td id="view3" class="padding" onclick="javascript:statView(3, 'index_guideTeacher')" width="120px">
          	<font color="blue">&nbsp;论文指导老师统计</font>
       	</td>
	</tr>
</table>
</form>
</div>
[@b.div id="moneyStatDiv" /]

<script>
	statView(0, 'stat_type');
	
	function statView(value, method) {
		for (i = 0; i < 4; i ++) {
			if (value == i) { document.getElementById("view" + i).className = "transfer"; } 
			else { document.getElementById("view" + i).className = "padding"; }
		}
		bg.form.submit(document.moneyStatForm, "inPayStat.action?method=" + method, "moneyStatDiv");
   	}
</script>
[@b.foot/]