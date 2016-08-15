[#ftl]
[@b.head/]
[@b.toolbar title="按月统计(${yearMonth})"]
	var menu = bar.addItem("设置", "statSetting()");
[/@]

<script type="text/javascript" src="${base}/static/scripts/jQchart-v0.03/jquery.jqchart.js" charset="utf-8"></script>
<script type="text/javascript" src="${base}/static/scripts/jQchart-v0.03/lib/jquery.dimensions.js"></script>
<style>
#myBgBox{ background: #e5f1f4; padding:30px; padding-top:5px; text-align:center; color:white; }
#myBgBox h5{ margin:5px; font-size:12px; color:blue }
.jQchart{ font-size:12px; }
.jQchart-bg{ margin-left:auto; margin-right:auto;}
.jQchart-labelData{ font-size:9px; }
.jQchart-title{ font-size:12px; }
</style>

[#function getIncome day][#list incomeMap?keys as key][#if day = key?number][#return incomeMap[key] /][/#if][/#list][#return 0 /][/#function]
[#function getPayment day][#list paymentMap?keys as key][#if day = key?number][#return paymentMap[key] /][/#if][/#list][#return 0 /][/#function]

[#assign YmaxValue = YmaxValue?default(200) /]
[#assign YgapValue = YgapValue?default(50) /]
[#assign fontSize = fontSize?default(12) /]
[#assign reportType = reportType?default('bar') /]

<div id="myBgBox" style="100%">
	<h5>
		[@b.datepicker label="年月" id="yearMonth" name="yearMonth" style="width:125px" format="yyyy-MM" value="${(yearMonth)!}" /]&nbsp;
		<input type="button" value="统计" onclick="replyStat()" />
	</h5>
	<canvas id="canvasMyID1" width="1100" height="300"></canvas>
</div>

<div style="display:none">
	<div id="statSettingDiv">
		<table width="100%" align="center">
			<tr>
				<td width="35%" align="right">Y轴最大值:</td>
				<td><input id="YmaxValue" style="width:50px" value="${YmaxValue}" />(10-10000之间,默认200)</td>
			</tr>
			<tr>
				<td align="right">Y轴间隔值:</td>
				<td><input id="YgapValue" style="width:50px" value="${YgapValue}" />(10-1000之间,默认50)</td>
			</tr>
			<tr>
				<td align="right">字体大小:</td>
				<td><input id="fontSize" style="width:50px" value="${fontSize}" />(9-15之间,默认12)</td>
			</tr>
			<tr>
				<td align="right">报表类型:</td>
				<td><select id="reportType" style="width:55px">
						<option value="bar" [#if reportType='bar']selected=true[/#if]>矩形图</option>
						<option value="line" [#if reportType='line']selected=true[/#if]>线条</option>
					</select></td>
			</tr>
			<tr>
				<td align="center" colspan="2">
					<input type="button" value="确定" onclick="replyStat()" />
				</td>
			</tr>
		</table>
		<br>
	</div>
</div>

[@b.form name="statSettingForm" action="!stat_month"]
	<input type="hidden" name="yearMonth" value="${yearMonth}" />
	<input type="hidden" name="YmaxValue" value="${YmaxValue}" />
	<input type="hidden" name="YgapValue" value="${YgapValue}" />
	<input type="hidden" name="fontSize" value="${fontSize}" />
	<input type="hidden" name="reportType" value="${reportType}" />
[/@]

<script>
	jQuery('div#colorbox').remove();
	jQuery('div#cboxOverlay').remove();
</script>
<script type="text/javascript" src="static/scripts/colorbox/jquery.colorbox-min.js"></script>
<script type="text/javascript">
	var datas = [
	  	[[#list 1..days as day]${getIncome(day)}[#if day_has_next],[/#if][/#list]],
	  	[[#list 1..days as day]${getPayment(day)}[#if day_has_next],[/#if][/#list]]
	];
	var labels = [
		[#list 1..days as day]'&nbsp;${day}'[#if day_has_next],[/#if][/#list]
	]
  
	var chartSetting1={
  		config : {
	    	type : '${reportType}',
	    	scaleY : { max:${YmaxValue}, gap:${YgapValue} } ,
	    	labelX : labels,
	    	bgGradient : {
	      		from  : '#00aaaa',
	      		to : '#000000'
	    	},
	    	colorSet : $.jQchart.colorSets.inPay
  		},
  		data : datas,
  		fontSize : ${fontSize}
	};

	jQuery(function(){
		jQuery('#canvasMyID1').jQchart(chartSetting1);
	})

	function statSetting() {
		jQuery.colorbox({transition:'none', title:"设置", overlayClose:false, width:"420px", height:"220px", inline:true, href:"#statSettingDiv"});
	}
	
	function replyStat() {
		var form = document.statSettingForm;
		form["YmaxValue"].value = jQuery("#YmaxValue").val();
		form["YgapValue"].value = jQuery("#YgapValue").val();
		form["fontSize"].value = jQuery("#fontSize").val();
		form["reportType"].value = jQuery("#reportType").val();
		form["yearMonth"].value = jQuery("#yearMonth").val();
		bg.form.submit(form);
	}
</script>
[@b.foot/]
