package com.sad.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;

import org.beangle.ems.security.User;
import org.beangle.model.pojo.LongIdObject;

import com.sad.model.baseCode.IncomePaymentType;

/**
 * 账单记录
 */
@Entity
public class IncomePaymentRecord extends LongIdObject {

	private static final long serialVersionUID = 1L;

	@NotNull
	private String name;

	private float amount;

	@NotNull
	private IncomePaymentType type = new IncomePaymentType();

	@NotNull
	private Date createOn;

	@NotNull
	private User user;

	private String remark;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public IncomePaymentType getType() {
		return type;
	}

	public void setType(IncomePaymentType type) {
		this.type = type;
	}

	public Date getCreateOn() {
		return createOn;
	}

	public void setCreateOn(Date createOn) {
		this.createOn = createOn;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
