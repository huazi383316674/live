package com.sad.web.action.shopping;

import java.util.Date;
import java.util.List;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.beangle.ems.security.model.UserBean;
import org.beangle.ems.web.action.SecurityActionSupport;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.shopping.ShoppingGoods;
import com.sad.model.shopping.ShoppingOrder;
import com.sad.model.shopping.ShoppingOrderInfo;

/**
 * 添加订单
 */
public class ShoppingOrderAction extends SecurityActionSupport {

	private static int buyCount = 30;

	public String index() {
		return forward();
	}

	public String toAdd() {
		put("buyCount", buyCount);
		return forward("new");
	}

	public String saveAdd() {
		ShoppingOrder order = new ShoppingOrder();
		order.setCreatedAt(new Date());
		order.setUpdatedAt(new Date());
		order.setUser(new UserBean(getUserId()));

		float totalMoney = 0;
		int seq = 0;
		for (int i = buyCount - 1; i >= 0; i--) {
			Long goodsId = getLong("goodsId_" + i);
			Integer count = getInteger("goodsCount_" + i);
			if (goodsId == null || count == null || count == 0) continue;

			ShoppingGoods goods = entityDao.get(ShoppingGoods.class, goodsId);

			ShoppingOrderInfo info = new ShoppingOrderInfo();
			info.setCount(count);
			info.setShoppingGoods(goods);
			info.setShoppingOrder(order);
			info.setSeq(seq);
			order.getOrderInfos().add(info);
			totalMoney += goods.getPrice() * count;

			seq++;
		}
		order.setTotalMoney(totalMoney);
		entityDao.saveOrUpdate(order);

		put("order", order);
		return forward("printOrder");
	}

	public String getGoordsByCode() {
		String goodsCode = get("goodsCode");
		if (StringUtils.isNotBlank(goodsCode)) {
			OqlBuilder<ShoppingGoods> query = OqlBuilder.from(ShoppingGoods.class, "goods");
			query.where("goods.code =:goodsCode", goodsCode);
			List<ShoppingGoods> shoppingGoods = entityDao.search(query);
			put("shoppingGoods", CollectionUtils.isNotEmpty(shoppingGoods) ? shoppingGoods.get(0) : null);
		}
		return forward("json_goodsInfo");
	}
}
