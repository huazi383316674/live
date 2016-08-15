package com.sad.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;

import org.beangle.model.pojo.LongIdObject;

import com.sad.model.baseCode.BusinessType;

@Entity
public class CommonUserConsume extends LongIdObject {

	private static final long serialVersionUID = 1L;

	/** 公共用户 */
	@NotNull
	private CommonUser commonUser;

	/** 金额 */
	private float amount;

	/** 业务类型 */
	@NotNull
	private BusinessType businessType;

	/** 日期 */
	@NotNull
	private Date createOn;

	private String remark;

	public CommonUser getCommonUser() {
		return commonUser;
	}

	public void setCommonUser(CommonUser commonUser) {
		this.commonUser = commonUser;
	}

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public BusinessType getBusinessType() {
		return businessType;
	}

	public void setBusinessType(BusinessType businessType) {
		this.businessType = businessType;
	}

	public Date getCreateOn() {
		return createOn;
	}

	public void setCreateOn(Date createOn) {
		this.createOn = createOn;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

}
