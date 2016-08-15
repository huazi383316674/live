package com.sad.model;

import java.sql.Date;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.OneToOne;

import org.beangle.model.pojo.LongIdObject;

/**
 * 债务归还记录
 */
@Entity
public class DebtReturnRecord extends LongIdObject {

	private static final long serialVersionUID = 1L;

	/** 债务清单 */
	private DebtRecord debtRecord;

	/** 归还金额 */
	private float amount;

	/** 归还时间 */
	private Date returnOn;

	/** 备注 */
	private String remark;

	/** 对应的收支记录 */
	@OneToOne(optional = true, cascade = { CascadeType.ALL }, orphanRemoval = true)
	private IncomePaymentRecord inPayRecord;

	public DebtRecord getDebtRecord() {
		return debtRecord;
	}

	public void setDebtRecord(DebtRecord debtRecord) {
		this.debtRecord = debtRecord;
	}

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public Date getReturnOn() {
		return returnOn;
	}

	public void setReturnOn(Date returnOn) {
		this.returnOn = returnOn;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public IncomePaymentRecord getInPayRecord() {
		return inPayRecord;
	}

	public void setInPayRecord(IncomePaymentRecord inPayRecord) {
		this.inPayRecord = inPayRecord;
	}

}
