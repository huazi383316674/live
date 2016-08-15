[#ftl]
[@b.head/]

[@b.grid items=shoppingOrders var="shoppingOrder"]
	[@b.gridbar]
		bar.addItem("${b.text('action.add')}", action.add());
		bar.addItem("${b.text('action.edit')}", action.edit());
		bar.addItem("${b.text('action.delete')}", action.remove());
		bar.addItem("${b.text('action.info')}", action.info());
	[/@]
	[@b.row]
		[@b.boxcol/]
		[@b.col title="订单编号" property="id" style="width:10%"]
			[@b.a href='!info?shoppingOrder.id=${shoppingOrder.id}' title='查看订单详细信息']${(shoppingOrder.id)!}[/@]
		[/@]
		[@b.col title="总计" property="totalMoney" style="width:8%"/]
		[@b.col title="创建人" property="user.fullname" style="width:8%" /]
		[@b.col title="创建时间" property="createdAt" style="width:8%"]${(shoppingOrder.createdAt?string("yyyy-MM-dd HH:mm"))!}[/@]
		[@b.col title="备注" style="width:15%"]
			[#assign remark = (shoppingOrder.remark)! /]<span title="${(remark)!}">
        	[#if remark?length &gt; 20]${remark[0..20]}...[#else]${(remark)!}[/#if]</span>
		[/@]
	[/@]
[/@]
[@b.foot/]