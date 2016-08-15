package com.sad.model.baseCode;

import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * 业务类型
 */
@Table(name = "A_BUSINESS_TYPES")
@Entity(name = "com.sad.model.baseCode.BusinessType")
public class BusinessType extends BaseCode {

	private static final long serialVersionUID = 1L;

	/** 收入 */
	public static Long income = new Long(1);

	/** 支出 */
	public static Long outlay = new Long(2);

}
