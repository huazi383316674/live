[#ftl]
[@b.head/]

[@b.grid items=shoppingGoodses var="shoppingGoods"]
	[@b.gridbar]
		bar.addItem("${b.text('action.add')}", action.add());
		bar.addItem("${b.text('action.edit')}", action.edit());
		bar.addItem("${b.text('action.delete')}", action.remove());
		bar.addItem("${b.text('action.info')}", action.info());
	[/@]
	[@b.row]
		[@b.boxcol/]
		[@b.col title="编号" property="code" style="width:10%" /]
		[@b.col title="名称" property="name" style="width:24%"]
			[@b.a href='shoppingGoods!info?shoppingGoods.id=${shoppingGoods.id}' title='查看商品详细信息']${(shoppingGoods.name)!}[/@]
		[/@]
		[@b.col title="出售价" property="price" style="width:8%" /]
		[@b.col title="批发价" property="inPrice" style="width:8%"/]
		[@b.col title="种类" property="type.name" style="width:10%"/]
		[@b.col title="描述" style="width:18%"]
			[#assign description = (shoppingGoods.description)! /]<span title="${(description)!}">
        	[#if description?length &gt; 20]${description[0..20]}...[#else]${(description)!}[/#if]</span>
		[/@]
		[@b.col title="备注" style="width:15%"]
			[#assign remark = (shoppingGoods.remark)! /]<span title="${(remark)!}">
        	[#if remark?length &gt; 20]${remark[0..20]}...[#else]${(remark)!}[/#if]</span>
		[/@]
	[/@]
[/@]
[@b.foot/]