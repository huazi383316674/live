[#ftl]
[@b.head /]
<link rel="stylesheet" type="text/css" href="${base}/static/styles/statusStyle.css" />
<link rel="stylesheet" type="text/css" href="${base}/static/styles/tablecloth/tablecloth.css" media="screen" />
<script src="${base}/static/scripts/list.js"></script>

[#function covertWeek week]
	[#if week=0][#return "星期日" /][#elseif week=1][#return "星期一" /]
	[#elseif week=2][#return "星期二" /][#elseif week=3][#return "星期三" /]
	[#elseif week=4][#return "星期四" /][#elseif week=5][#return "星期五" /]
	[#elseif week=6][#return "星期六" /][#else][#return "" /][/#if]
[/#function]

<table cellspacing="0" cellpadding="0" class="clothTable" style="width:100%" onmouseup="saveInfos()">
	<tr>
		<th width="18%"><b>日期 / 姓名</b></th>
		[#list commonUsers! as commonUser]
			<th width="${82/commonUsers?size}%" onclick="viewConsumes('${commonUser.name}');"><b>${commonUser.name}</b></th>
		[/#list]
	</tr>
	
	[#list datesByWeek as date]
	<tr height="40px">
		<td><font [#if nowWeekDay?? && nowWeekDay=date_index]color='red'[#else]color='#4796AD'[/#if]>${covertWeek(date_index)}&nbsp;(${date?string('MM-dd')})</font></td>
		
		[#list commonUsers! as commonUser]
			<td onclick="viewEditDiv('${date_index}${commonUser.id}')">
				<div id="infoDiv${date_index}${commonUser.id}">
					[#list statList! as stats]
						[#if stats[0]?string('yyyy-MM-dd') = date?string('yyyy-MM-dd')]
							[#assign total = stats[commonUser_index*2+1]?default(0) - stats[commonUser_index*2+2]?default(0) /]
							
							[#if total > 0]<div class='tag accepted'>${total}</div>
							[#elseif total < 0]<div class='tag rejected'>${total}</div>[/#if]
						[/#if]
					[/#list]
				</div>
				<div id="editDiv${date_index}${commonUser.id}" style="display:none">
					<select style="width:50px" id="type_${date_index}${commonUser.id}">
						<option value="2">消费</option>
						<option value="1">存入</option>
					</select>
					<input style="width:40px" id="amount_${date_index}${commonUser.id}" />					
        		</div>
			</td>
		[/#list]
	</tr>
	[/#list]
	
	<tr height="40px">
		<td width="18%"><b><font color='#4796AD'>金额统计<span id="totalMoneySpan">(${totalMoney})</span></font></b></td>
		[#list commonUsers! as commonUser]
			<td id="totalMoneySpan_${commonUser.id}">
				[#assign total = totalStats[commonUser_index*2+1]?default(0) - totalStats[commonUser_index*2+2]?default(0) /]
				
				[#if total > 0]<div class='tag accepted'>&nbsp;${total}&nbsp;</div>
				[#elseif total < 0]<div class='tag rejected'>&nbsp;${total}&nbsp;</div>[/#if]
			</td>
		[/#list]
	</tr>
</table>

[@b.form name="consumeListForm" /]
<script>
	function viewEditDiv(value) {
		document.getElementById("infoDiv" + value).style.display = "none";
		document.getElementById("editDiv" + value).style.display = "block";
		document.getElementById("amount_" + value).value = "";
		document.getElementById("amount_" + value).focus();
	}
	
	function viewConsumes(commonUserName) {
		var form = document.consumeListForm;
		bg.form.addInput(form, "consume.createOn", "${Parameters['nowDate']}");
		bg.form.addInput(form, "consume.commonUser.name", commonUserName);
		bg.form.submit(form, "commonUserConsume!consumes.action");
	}
	
	var commonUserIds = new List();
	[#list commonUsers as commonUser]
		commonUserIds.add(${commonUser.id});
	[/#list]
	var dateIndexs = new List();
	[#list datesByWeek as date]
		dateIndexs.add(${date_index});
	[/#list]
	
	function saveInfos() {
		for (i = 0; i < dateIndexs.size(); i++) {
			for (j = 0; j < commonUserIds.size(); j++) {
			
				if (document.getElementById("editDiv" + dateIndexs.get(i) + "" + commonUserIds.get(j)).style.display == "block") {
					
					var amonut = jQuery("#amount_" + dateIndexs.get(i) + commonUserIds.get(j)).val();
					var type = jQuery("#type_" + dateIndexs.get(i) + commonUserIds.get(j)).val();
					var dateIndex_ = dateIndexs.get(i);
					var userId_ = commonUserIds.get(j);
					if (amonut == "") {
						document.getElementById("editDiv" + dateIndex_ + userId_).style.display = "none";
						document.getElementById("infoDiv" + dateIndex_ + userId_).style.display = "block";
						return;
					}
					
					var url = "commonUserConsume!ajaxSave.action?commonUserId=" + commonUserIds.get(j) + "&amount=" + amonut + "&typeId=" + type + "&dateIndex=" + dateIndexs.get(i) + "&nowDate=${Parameters['nowDate']}";
					jQuery.get(url, function(data) {
						var dataObj = eval("("+data+")");
						
						var content = "";
						jQuery.each(dataObj.datas, function(idx,item) {
							var total = item.income - item.payment;
							if (total >= 0) {
								content = "<div class='tag accepted'>"+ total +"</div>";
							} else {
								content = "<div class='tag rejected'>"+ total +"</div>";
							}
						})
						
						document.getElementById("infoDiv" + dateIndex_ + userId_).innerHTML = content;
						document.getElementById("editDiv" + dateIndex_ + userId_).style.display = "none";
						document.getElementById("infoDiv" + dateIndex_ + userId_).style.display = "block";
						
						// 刷新用户总计和总金额
						jQuery.get("commonUserConsume!refreshStat.action?commonUserId=" + userId_, function(data) {
							var totalMoney = 0;
							var totalMoneyByUser = 0;
							var dataObjs = eval("("+data+")");
							jQuery.each(dataObjs.datas, function(idx,item) {
								totalMoney = item.totalMoney;
								totalMoneyByUser = item.totalMoneyByUser;
							})
							document.getElementById("totalMoneySpan").innerHTML = "(" + totalMoney + ")";
							if (totalMoneyByUser >= 0) {
								document.getElementById("totalMoneySpan_" + userId_).innerHTML = "<div class='tag accepted'>" + totalMoneyByUser + "</div>";
							} else {
								document.getElementById("totalMoneySpan_" + userId_).innerHTML = "<div class='tag rejected'>" + totalMoneyByUser +"</div>";
							}
						});
					});
				}
			}
		}
		
	}
</script>
[@b.foot /]