[#ftl]
[@b.head/]
[@b.toolbar title="添加订单"]
	bar.addBlankItem();
[/@]
<script type="text/javascript" src="${base}/static/scripts/money/caculate.js"></script>
<style>
	.formTable { font-size:16px }
	.inputStyle { height:22px; font-size:18px; font-weight:bold; text-align:center }
</style>

<div style="height:37px">
	请扫描条形码：<input class="inputStyle" style="width:200px" id="goodsCode" />
	&nbsp;<span style="font-color:red" id="noticeSpan"></span>
</div>

[@b.form name="newOrderForm" target="contentDiv" action="!saveAdd"]
<table class="formTable" style="width:100%; text-align:center;">
	<tr style="height:30px; background-color:#C7DBFF; font-weight:bold;">
		<td colspan="4" align="right">金额总计:&nbsp;&nbsp;&nbsp;</td>
		<td colspan="2" id="totalMoney" style="color:red; font-size:20pt; text-align:left"></td>
	</tr>

	<tr style="background-color:#C7DBFF; font-weight:bold; height:30px">
		<td width="15%">商品编号</td>
		<td width="28%">商品名称</td>
		<td width="10%">单价(元)</td>
		<td width="10%">数量</td>
		<td width="12%">金额</td>
		<td>描述</td>
	</tr>

	[#list 0..buyCount-1 as i]
	<tr style="height:37px;display:none" id="tr_goods_${i}" [#if i%2=0]bgcolor="#ebeaef"[/#if]>
		<input id="goodsId_${i}" name="goodsId_${i}" style="display:none" />
		<td id="td_goodsCode_${i}"></td>
		<td id="td_goodsName_${i}"></td>
		<td id="td_goodsPrice_${i}"></td>
		<td><input class="inputStyle" style="width:90%" id="goodsCount_${i}" name="goodsCount_${i}" maxlength="5" onclick="this.select()" /></td>
		<td id="td_goodsMoney_${i}"></td>
		<td id="td_goodsDescription_${i}" style="font-size:12px"></td>
	</tr>
	[/#list]
</table>
[/@]

<script>
	document.getElementById('goodsCode').focus();
	
	jQuery(function() {
		[#list 0..buyCount-1 as i]
		jQuery("#goodsCount_${i}").bind("keypress",function(event){ if(event.keyCode == "13") { document.getElementById('goodsCode').focus(); } });
        [/#list]
        
        jQuery("#goodsCode").bind("keypress",function(event){ if(event.keyCode == "13") submitOrder(); });
	})
	
	// 提交订单
	function submitOrder() {
		art.dialog({
		    content: '确定提交订单吗?',
		    yesFn: function () {
				bg.form.submit(document.newOrderForm);
				//return true;
		    },
		    noText: '关闭',
		    noFn: function() { document.getElementById('goodsCode').focus(); }
		});
	}

	// 获取商品信息	
	function getGoordsInfo() {
		var goodsCode = document.getElementById('goodsCode').value;
		if (goodsCode == "") return;
		
		jQuery.get("shoppingOrder!getGoordsByCode.action?goodsCode=" + goodsCode, function(data) {
			var dataObj = eval("("+data+")");
			
			if (dataObj.datas[0].id != "") {
				for (var i = ${buyCount-1}; i >= 0; i --) {
					if (document.getElementById("goodsId_" + i).value == "") {
						jQuery("#goodsId_" + i).val(dataObj.datas[0].id);
						jQuery("#td_goodsCode_" + i).html(dataObj.datas[0].code);
						jQuery("#td_goodsName_" + i).html(dataObj.datas[0].name);
						jQuery("#td_goodsPrice_" + i).html(dataObj.datas[0].price);
						jQuery("#goodsCount_" + i).val(1);
						jQuery("#td_goodsDescription_" + i).html(dataObj.datas[0].description);
						jQuery("#td_goodsMoney_" + i).html(dataObj.datas[0].price);
						
						jQuery("#tr_goods_" + i).show(); 
						caculateTotalMoney();
						document.getElementById('goodsCode').value = ""; jQuery("#noticeSpan").html(""); 
						return;
					} 
				}
			} else {
				jQuery("#noticeSpan").html("木有找到商品");
			}
		});	
	}
	
	//ie浏览器
	if (/msie/i.test(navigator.userAgent)) {
		document.getElementById('goodsCode').onpropertychange = getGoordsInfo;	 
		[#list 0..buyCount-1 as i]
			document.getElementById('goodsCount_${i}').onpropertychange = function() { if (this.value=="") return; var count = parseFloat(this.value); var price = parseFloat(jQuery("#td_goodsPrice_${i}").html()); if (count == null || isNaN(count) || price == null || isNaN(price)) { this.value=1;count=1; } jQuery("#td_goodsMoney_${i}").html(accMul(count,price)); caculateTotalMoney(); };
		[/#list]
	} else { 
		//非ie浏览器，比如Firefox
		document.getElementById('goodsCode').addEventListener("input", getGoordsInfo, false);	 
		[#list 0..buyCount-1 as i]
			document.getElementById('goodsCount_${i}').addEventListener("input", function() { if (this.value=="") return; var count = parseFloat(this.value); var price = parseFloat(jQuery("#td_goodsPrice_${i}").html()); if (count == null || isNaN(count) || price == null || isNaN(price)) { this.value=1;count=1; } jQuery("#td_goodsMoney_${i}").html(accMul(count,price)); caculateTotalMoney(); }, false);
		[/#list]
	} 

	// 计算总金额
	function caculateTotalMoney() {
		var totalMoney = 0;
		for (var i = 0; i <= ${buyCount -1}; i++) {
			var money = parseFloat(jQuery("#td_goodsMoney_" + i).html());
			if (money != null && !isNaN(money)) totalMoney = accAdd(totalMoney, money); 
		} 
		jQuery("#totalMoney").html(totalMoney);
	}
</script>