[#ftl]
[@b.head/]
[@b.toolbar title="按类型统计(${yearMonth})"]
[/@]

<style>
	#myBgBox{ background: #e5f1f4; padding:30px; padding-top:5px; text-align:center; color:white; }
	#myBgBox h5{ margin:5px; font-size:12px; color:blue }
</style>

[@b.form name="statSettingForm" action="!stat_type" target="moneyStatDiv"]
<table style="text-align:center; width:100%; height:30px; background:#DEEDF7">
	<tr><td>
		<b>年月</b>:[@b.datepicker id="yearMonth" name="yearMonth" style="width:125px" format="yyyy-MM" value="${(yearMonth)!}" /]&nbsp;
		<input type="button" value="统计" onclick="replyStat()" />
	</td></tr>
</table>
[/@]

<div id="holder" style="width:100%; background:#DEEDF7"></div>

<script type="text/javascript">
	var txtattr = { font: "15px sans-serif","font-weight": 800 };
    var r = Raphael("holder"),
    
    [#assign outlayTotal = 0 /]
    [#assign incomeTotal = 0 /]
	pie = r.piechart(220, 150, 100, 
		[[#list outlayTypes! as type][#assign amount = outlayMap[type.id?string] /][#assign outlayTotal = outlayTotal + amount /]${amount}[#if type_has_next],[/#if][/#list]], 
		{ legend: [[#list outlayTypes! as type]'${type.name} ￥${outlayMap[type.id?string]}'[#if type_has_next],[/#if][/#list]], legendpos: "east"});
	
	
    pie1 = r.piechart(700, 150, 100, 
		[[#list incomeTypes! as type][#assign amount = incomeMap[type.id?string] /][#assign incomeTotal = incomeTotal + amount /]${amount}[#if type_has_next],[/#if][/#list]], 
		{ legend: [[#list incomeTypes! as type]'${type.name} ￥${incomeMap[type.id?string]}'[#if type_has_next],[/#if][/#list]], legendpos: "east"});
		 
    r.text(220, 20, "支出百分比分布图(总￥${outlayTotal})").attr(txtattr);
    r.text(700, 20, "收入百分比分布图(总￥${incomeTotal})").attr(txtattr);
    	
    pie.hover(function () {
        this.sector.stop(); this.sector.scale(1.1, 1.1, this.cx, this.cy);
        if (this.label) { this.label[0].stop(); this.label[0].attr({ r: 7.5 }); this.label[1].attr({ "font-weight": 800 }); }
    }, function () {
        this.sector.animate({ transform: 's1 1 ' + this.cx + ' ' + this.cy }, 500, "bounce");
        if (this.label) { this.label[0].animate({ r: 5 }, 500, "bounce"); this.label[1].attr({ "font-weight": 400 }); }
    });
    
    pie1.hover(function () {
        this.sector.stop(); this.sector.scale(1.1, 1.1, this.cx, this.cy);
        if (this.label) { this.label[0].stop(); this.label[0].attr({ r: 7.5 }); this.label[1].attr({ "font-weight": 800 }); }
    }, function () {
        this.sector.animate({ transform: 's1 1 ' + this.cx + ' ' + this.cy }, 500, "bounce");
        if (this.label) { this.label[0].animate({ r: 5 }, 500, "bounce"); this.label[1].attr({ "font-weight": 400 }); }
    });

    function replyStat() { bg.form.submit(document.statSettingForm); }
</script>
[@b.foot/]
