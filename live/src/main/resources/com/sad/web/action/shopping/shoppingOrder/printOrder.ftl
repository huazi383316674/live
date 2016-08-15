[#ftl]
[@b.head/]
[@b.toolbar title="订单打印"]
	bar.addBlankItem();
[/@]

<table class="formTable" style="width:80%" align="center">
	<tr style="background-color:#C7DBFF; font-weight:bold; height:25px">
		<td>商品名称</td>
		<td>单价</td>
		<td>数量</td>
		<td>小计</td>
	</tr>
	[#list order.orderInfos! as info]
	<tr>
		<td>${info.shoppingGoods.name}</td>
		<td>${info.shoppingGoods.price}</td>
		<td>${info.count}</td>
		<td>${info.count * info.shoppingGoods.price}</td>
	</tr>
	[/#list]
	<tr>
		<td></td>
		<td></td>
		<td></td>
		<td>总计：${order.totalMoney}</td>
	</tr>
</table>