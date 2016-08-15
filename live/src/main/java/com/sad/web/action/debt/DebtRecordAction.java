package com.sad.web.action.debt;

import org.apache.commons.lang.StringUtils;
import org.beangle.commons.collection.Order;
import org.beangle.commons.lang.StrUtils;
import org.beangle.ems.security.model.UserBean;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.dao.DebtDao;
import com.sad.model.DebtRecord;
import com.sad.model.IncomePaymentRecord;
import com.sad.model.DebtRecord.DebtType;
import com.sad.model.baseCode.BusinessType;
import com.sad.web.action.MoneyCommonAction;

/**
 * 债务清单管理
 */
public class DebtRecordAction extends MoneyCommonAction {

	private DebtDao debtDao;

	public String index() {
		addBaseCode("businessTypes", BusinessType.class);
		return forward();
	}

	public String search() {
		OqlBuilder<DebtRecord> query = OqlBuilder.from(DebtRecord.class, "debtRecord");
		populateConditions(query);
		if (StringUtils.isNotBlank(get("debtType"))) {
			query.where("debtRecord.debtType =:debtType", DebtType.getDebtType(get("debtType")));
		}
		if (StringUtils.isNotBlank(get("createYearManth"))) {
			query.where("to_char(debtRecord.createOn, 'yyyy-MM') =:createYearManth", get("createYearManth"));
		}
		if (StringUtils.isNotBlank(get("returnYearMonth"))) {
			query.where("to_char(debtRecord.returnOn, 'yyyy-MM') =:returnYearMonth", get("returnYearMonth"));
		}

		if (StringUtils.isBlank(get(Order.ORDER_STR))) {
			query.orderBy("debtRecord.createOn desc");
		} else {
			query.orderBy(get(Order.ORDER_STR));
		}
		query.limit(getPageLimit());
		put("debtRecords", entityDao.search(query));
		return forward();
	}

	public String edit() {
		Long debtRecordId = getLong("debtRecordId");

		if (debtRecordId != null) {
			DebtRecord debtRecord = entityDao.get(DebtRecord.class, debtRecordId);
			put("debtRecord", debtRecord);
		}
		return forward();
	}

	public String addIncomePaymentRecord() {
		DebtRecord debtRecord = populateEntity(DebtRecord.class, "debtRecord");

		if (debtRecord.getId() != null && debtRecord.getInPayRecord() != null) {
			put("record", debtRecord.getInPayRecord());
		} else {
			IncomePaymentRecord record = new IncomePaymentRecord();
			record.setCreateOn(debtRecord.getCreateOn());
			record.setName(debtRecord.getName());
			record.setAmount(debtRecord.getAmount());
			if (get("debtType").equals(DebtType.borrowIn.name())) {
				record.getType().setBusinessType(entityDao.get(BusinessType.class, BusinessType.income));
				record.setRemark(DebtType.borrowIn.getFullName() + " " + debtRecord.getDebtUserName());
			} else {
				record.getType().setBusinessType(entityDao.get(BusinessType.class, BusinessType.outlay));
				record.setRemark(DebtType.borrowOut.getFullName() + " " + debtRecord.getDebtUserName());
			}
			put("record", record);
		}

		addBaseCode("businessTypes", BusinessType.class);
		return forward();
	}

	/**
	 * 保存，并添加收支记录
	 */
	public String save() {
		DebtRecord debtRecord = populateEntity(DebtRecord.class, "debtRecord");
		debtRecord.setUser(new UserBean(getUserId()));
		debtRecord.setDebtType(DebtType.getDebtType(get("debtType")));

		IncomePaymentRecord record = populateEntity(IncomePaymentRecord.class, "record");

		debtDao.saveDebtAndInPayRecord(debtRecord, record);
		return redirect("search", "保存成功");
	}

	public String remove() {
		Long[] debtRecordIds = StrUtils.splitToLong(get("debtRecordIds"));
		entityDao.remove(entityDao.get(DebtRecord.class, debtRecordIds));
		return redirect("search", "删除成功");
	}

	/**
	 * 直接保存，不添加收支记录
	 */
	public String quickSave() {
		DebtRecord debtRecord = populateEntity(DebtRecord.class, "debtRecord");
		debtRecord.setUser(new UserBean(getUserId()));
		debtRecord.setDebtType(DebtType.getDebtType(get("debtType")));
		debtRecord.setInPayRecord(null);
		entityDao.saveOrUpdate(debtRecord);
		return redirect("search", "保存成功");
	}

	public void setDebtDao(DebtDao debtDao) {
		this.debtDao = debtDao;
	}
}
