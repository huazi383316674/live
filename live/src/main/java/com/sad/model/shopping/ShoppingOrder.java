package com.sad.model.shopping;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;

import org.beangle.commons.comparators.PropertyComparator;
import org.beangle.ems.security.User;
import org.beangle.model.pojo.LongIdObject;

/**
 * 商品订单类
 */
@Entity
public class ShoppingOrder extends LongIdObject {

	private static final long serialVersionUID = 1L;

	/** 商品订单明细 */
	@OneToMany(mappedBy = "shoppingOrder", orphanRemoval = true, targetEntity = ShoppingOrderInfo.class, cascade = { CascadeType.ALL })
	private List<ShoppingOrderInfo> orderInfos = new ArrayList<ShoppingOrderInfo>();

	/** 备注 */
	private String remark;

	/** 产生时间 */
	@NotNull
	private Date createdAt;

	/** 最后修改时间 */
	private Date updatedAt;

	/** 创建用户 */
	@NotNull
	private User user;

	private float totalMoney;

	public List<ShoppingOrderInfo> getOrderInfos() {
		if (orderInfos != null) {
			Collections.sort(orderInfos, new PropertyComparator<ShoppingOrderInfo>("seq asc"));
		}
		return orderInfos;
	}

	public void setOrderInfos(List<ShoppingOrderInfo> orderInfos) {
		this.orderInfos = orderInfos;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public float getTotalMoney() {
		return totalMoney;
	}

	public void setTotalMoney(float totalMoney) {
		this.totalMoney = totalMoney;
	}

}
