[#ftl]
[@b.head/]
[@b.toolbar title="公共用户消费管理"]
	bar.addItem("余额同步", "toMoneySync()");
[/@]
[@b.messages slash='3'/]

<table class="indexpanel">
	<tr>
		<td class="index_view">
			<div style="background: url('${base}/static/images/semesterBarBg.png') repeat-x scroll 50% 50% #DEEDF7;border: 1px solid #AED0EA;color: #222222;height:28px;">
				[@b.form name="commonCalendarSearchForm" action="!search" target="contentDiv"]
					[@b.datepicker label="日期" name="nowDate" style="width:125px"  format="yyyy-MM-dd" value="${(nowDate?string('yyyy-MM-dd'))!}" /]
					<input type="button" value=" 查询 " onclick="bg.form.submit(document.commonCalendarSearchForm);" />
				[/@]
			</div>
	   	</td>
	</tr>
	<tr>
		<td class="index_content">
			[@b.div id="contentDiv" /]
		</td>
	</tr>
</table>

<div style="display:none">
	<div id="moneySyncDiv">
		<table width="100%" align="center">
			<tr>
				<td align="right" width="45%" height="30px"><font color="red">*</font>实际金额:</td>
				<td><input name="factMoney" id="factMoney" style="width:80px" type="text" maxlength="5" /></td>
			</tr>
			<tr>
				<td align="right" width="45%" height="30px">影响范围:</td>
				<td><select name="userRange" id="userRange" style="width:85px" >
						<option value="enabledUser">启用用户</option>
						<option value="allUser">全部用户</option>
					</select>
				</td>
			</tr>
			<tr>
				<td align="center" colspan="2" height="30px"><input type="button" value=" 开始同步 " onclick="moneySync()" /></td>
			</tr>
		</table>
	</div>	
</div>
<script>
	jQuery('div#colorbox').remove();
	jQuery('div#cboxOverlay').remove();
</script>
<script type="text/javascript" src="static/scripts/colorbox/jquery.colorbox-min.js"></script>
<script>
	jQuery(function(){
		bg.form.submit(document.commonCalendarSearchForm);
	})
	
	function toMoneySync() {
		jQuery.colorbox({transition:'none', title:"余额同步", overlayClose:false, width:"420px", height:"210px", inline:true, href:"#moneySyncDiv"});
		document.getElementById("factMoney").focus();
	}

	function moneySync() {
		var reg = /^(?:[1-9][0-9]*(?:\.[0-9]+)?|0(?:\.[0-9]+)?)$/;
		var factMoney = document.getElementById("factMoney");
		
		if (factMoney.value == "") { alert("请填写实际金额!"); factMoney.focus(); return; }
		if (!reg.test(factMoney.value)) { alert("实际金额格式有误!"); factMoney.focus(); return; }
		
		bg.form.addInput(document.commonCalendarSearchForm, "factMoney", factMoney.value);
		bg.form.addInput(document.commonCalendarSearchForm, "userRange", document.getElementById("userRange").value);
		bg.form.submit(document.commonCalendarSearchForm, "commonUserConsume!moneySync.action", "main");
	}
</script>
[@b.foot/]