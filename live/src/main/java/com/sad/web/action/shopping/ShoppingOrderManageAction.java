package com.sad.web.action.shopping;

import org.apache.commons.lang.StringUtils;
import org.beangle.commons.collection.Order;
import org.beangle.ems.web.action.SecurityActionSupport;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.shopping.ShoppingOrder;

/**
 * 订单维护
 */
public class ShoppingOrderManageAction extends SecurityActionSupport {

	protected String getEntityName() {
		return ShoppingOrder.class.getName();
	}

	public String index() {
		return forward();
	}

	public String search() {
		OqlBuilder<ShoppingOrder> query = OqlBuilder.from(ShoppingOrder.class, "shoppingOrder");
		populateConditions(query);
		if (StringUtils.isBlank(get(Order.ORDER_STR))) {
			query.orderBy("shoppingOrder.createdAt desc");
		} else {
			query.orderBy(get(Order.ORDER_STR));
		}
		query.limit(getPageLimit());
		put("shoppingOrders", entityDao.search(query));
		return forward();
	}

	public String edit() {
		return forward();
	}

	public String remove() {
		return forward();
	}

}
