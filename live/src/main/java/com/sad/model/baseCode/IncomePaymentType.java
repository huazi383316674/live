package com.sad.model.baseCode;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 收支明细类型
 */
@Entity
@Table(name = "A_INCOME_PAYMENT_TYPES")
public class IncomePaymentType extends BaseCode {

	private static final long serialVersionUID = 1L;

	private BusinessType businessType;

	public BusinessType getBusinessType() {
		return businessType;
	}

	public void setBusinessType(BusinessType businessType) {
		this.businessType = businessType;
	}

}
