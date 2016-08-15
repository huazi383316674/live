package com.sad.web.action.shopping;

import org.apache.commons.lang.StringUtils;
import org.beangle.commons.collection.Order;
import org.beangle.ems.web.action.SecurityActionSupport;
import org.beangle.model.Entity;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.shopping.ShoppingGoods;
import com.sad.model.shopping.ShoppingGoodsType;

/**
 * 购物管理—商品信息维护
 */
public class ShoppingGoodsAction extends SecurityActionSupport {
	
	public String index() {
		addBaseCode("shoppingGoodsTypes", ShoppingGoodsType.class);
		return forward();
	}

	public String search() {
		put("shoppingGoodses", entityDao.search(buildGoodsQuery()));
		return forward();
	}

	private OqlBuilder<ShoppingGoods> buildGoodsQuery() {
		OqlBuilder<ShoppingGoods> query = OqlBuilder.from(ShoppingGoods.class, "shoppingGoods");
		populateConditions(query);

		if (StringUtils.isBlank(get(Order.ORDER_STR))) {
			query.orderBy("shoppingGoods.code");
		} else {
			query.orderBy(get(Order.ORDER_STR));
		}
		query.limit(getPageLimit());
		return query;
	}

	@Override
	protected void editSetting(Entity<?> entity) {
		addBaseCode("shoppingGoodsTypes", ShoppingGoodsType.class);
	}

	@Override
	protected String getEntityName() {
		return ShoppingGoods.class.getName();
	}
}
