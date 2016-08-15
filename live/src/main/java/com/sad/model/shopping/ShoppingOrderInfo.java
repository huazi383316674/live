package com.sad.model.shopping;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.validation.constraints.NotNull;

import org.beangle.model.pojo.LongIdObject;

/**
 * 商品订单明细
 */
@Entity
public class ShoppingOrderInfo extends LongIdObject {

	private static final long serialVersionUID = 1L;

	/** 商品 */
	@NotNull
	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "shopping_goods_id")
	private ShoppingGoods shoppingGoods;

	/** 购买的数量 */
	@NotNull
	private int count = 1;

	/** 所属订单 */
	@NotNull
	@ManyToOne(fetch = FetchType.LAZY)
	private ShoppingOrder shoppingOrder;

	private int seq;

	public ShoppingGoods getShoppingGoods() {
		return shoppingGoods;
	}

	public void setShoppingGoods(ShoppingGoods shoppingGoods) {
		this.shoppingGoods = shoppingGoods;
	}

	public int getCount() {
		return count;
	}

	public void setCount(int count) {
		this.count = count;
	}

	public ShoppingOrder getShoppingOrder() {
		return shoppingOrder;
	}

	public void setShoppingOrder(ShoppingOrder shoppingOrder) {
		this.shoppingOrder = shoppingOrder;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

}
