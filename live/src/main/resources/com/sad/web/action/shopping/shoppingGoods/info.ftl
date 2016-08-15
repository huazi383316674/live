[#ftl/]
[@b.toolbar title="商品详细信息"]
	bar.addBack();
[/@]

<style>
	.infoTable tr { height: 30px }
</style>
<table class="infoTable" width="100%">
    <tr>
        <td class="title">商品编号:</td>
        <td class="content">${(shoppingGoods.code)!}</td>
        <td class="title">商品名称:</td>
        <td class="content"> ${(shoppingGoods.name)!}</td>
    </tr>
    <tr>
        <td class="title">出售价:</td>
        <td class="content">${(shoppingGoods.price)!}  </td>
        <td class="title">批发价:</td>
        <td class="content">${(shoppingGoods.inPrice)!}</td>
    </tr>
    <tr>
        <td class="title">种类:</td>
        <td class="content" colspan="3">${(shoppingGoods.type.name)!}</td>
    </tr>
	<tr>
        <td class="title">描述:</td>
        <td class="content" colspan="3">${(shoppingGoods.description?html?replace("\n\r", "<br>")?replace("\n", "<br>")?replace("\r", "<br>"))!}</td>
    </tr>
    <tr>
        <td class="title">备注:</td>
        <td class="content" colspan="3">${(shoppingGoods.remark?html?replace("\n\r", "<br>")?replace("\n", "<br>")?replace("\r", "<br>"))!}</td>
    </tr>
</table>
[@b.foot/]
