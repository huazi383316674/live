[#ftl]
[@b.head/]
[@b.toolbar title="商品维护"]
	bar.addBlankItem();
[/@]

<table class="indexpanel">
	<tr>
		<td class="index_view">
		[@b.form name="shoppingGoodsSearchForm" action="!search" title="ui.searchForm" target="contentDiv" theme="search"]
			[@b.textfield name="shoppingGoods.code" label="商品编号" /]
			[@b.textfield name="shoppingGoods.name" label="商品名称" /]
			[@b.textfield name="shoppingGoods.price" label="出售价" /]
			[@b.textfield name="shoppingGoods.inPrice" label="批发价" /]
			[@b.select items=shoppingGoodsTypes! label='商品种类' empty="..." name="shoppingGoods.type.id"/]
		[/@]
	   	</td>
		<td class="index_content">
			[@b.div id="contentDiv" href="!search" /]
		</td>
	</tr>
</table>
[@b.foot/]