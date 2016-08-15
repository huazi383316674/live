[#ftl/]
[@b.toolbar title="订单详细信息"]
	bar.addBack();
[/@]

<style>
	.infoTable tr { height: 30px }
</style>
<table class="infoTable" width="100%">
    <tr>
        <td class="title">订单编号:</td>
        <td class="content" colspan="3"><b>${(shoppingOrder.id)!}</b></td>
    </tr>
    <tr>
        <td class="title" style="width:20%">订单创建人:</td>
        <td class="content" style="width:25%">${(shoppingOrder.user.fullname)!}</td>
       <td class="title" style="width:20%">金额总计:</td>
        <td class="content"><b>${(shoppingOrder.totalMoney)!}</b></td>
    </tr>
    <tr>
        <td class="title">订单产生时间:</td>
        <td class="content">${(shoppingOrder.createdAt?string("yyyy-MM-dd HH:mm"))!}</td>
        <td class="title">订单更新时间:</td>
        <td class="content">${(shoppingOrder.updatedAt?string("yyyy-MM-dd HH:mm"))!}</td>
    </tr>
     <tr>
        <td class="title">备注:</td>
        <td class="content" colspan="3">${(shoppingOrder.remark?html?replace("\n\r", "<br>")?replace("\n", "<br>")?replace("\r", "<br>"))!}</td>
    </tr>
</table>

<table class="infoTable" width="100%">
	[#list shoppingOrder.orderInfos! as info]
    <tr>
        <td class="title" style="width:12%">商品名称:</td>
        <td class="content">
        	[@b.a href='shoppingGoods!info?shoppingGoods.id=${info.shoppingGoods.id}' title='查看商品详细信息']${(info.shoppingGoods.name)!}[/@]
        </td>
        <td class="title" style="width:10%">零售价:</td>
        <td class="content" style="width:12%">${(info.shoppingGoods.price)!}</td>
		<td class="title" style="width:10%">数量:</td>
        <td class="content" style="width:12%">${(info.count)!}</td>
        <td class="title" style="width:10%">小计:</td>
        <td class="content" style="width:12%">${(info.count * info.shoppingGoods.price)!}</td>
    </tr>
    [/#list]
</table>
[@b.foot/]
