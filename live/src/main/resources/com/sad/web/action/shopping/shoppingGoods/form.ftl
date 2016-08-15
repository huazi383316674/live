[#ftl]
[@b.head/]
[@b.toolbar title="添加/更新商品信息"]
	bar.addBack();
[/@]

[@b.form name="shoppingGoodsEditForm" action="!save" title="" theme="list"]
	[@b.textfield name="shoppingGoods.code" label="商品编号" value="${(shoppingGoods.code)!}" maxlength="50" required="true" style="width:150px" /]
	[@b.textfield name="shoppingGoods.name" label="商品名称" value="${(shoppingGoods.name)!}" maxlength="100" required="true" style="width:150px" /]
	[@b.textfield name="shoppingGoods.price" label="出售价" value="${(shoppingGoods.price)!}" maxlength="8" required="true" style="width:150px" /]
	[@b.textfield name="shoppingGoods.inPrice" label="批发价" value="${(shoppingGoods.inPrice)!}" maxlength="8" required="true" style="width:150px" /]
	[@b.select label="种类" name="shoppingGoods.type.id" items=shoppingGoodsTypes! value=(shoppingGoods.type.id)! empty="..." required="true" style="width:155px" /]
	[@b.textarea cols="70" rows="4" label="描述" name="shoppingGoods.description" maxlength="500" value="${(shoppingGoods.description)!}" comment="不超过500字"/]
	[@b.textarea cols="70" rows="4" label="备注" name="shoppingGoods.remark" maxlength="500" value="${(shoppingGoods.remark)!}" comment="不超过500字"/]
	[@b.formfoot]
		[@b.redirectParams/]
		[@b.submit value="${b.text('action.save')}"/]		
		<input type="reset" value="${b.text("action.reset")}" />
		<input type="hidden" name="shoppingGoods.id" value="${(shoppingGoods.id)!}" />
	[/@]
[/@]

<script>
	jQuery(function() {
		document.shoppingGoodsEditForm["shoppingGoods.code"].focus();
	})
</script>
[@b.foot/]