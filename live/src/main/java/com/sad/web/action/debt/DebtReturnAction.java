package com.sad.web.action.debt;

import java.util.List;

import org.beangle.commons.lang.StrUtils;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.dao.DebtDao;
import com.sad.model.DebtRecord;
import com.sad.model.DebtReturnRecord;
import com.sad.model.IncomePaymentRecord;
import com.sad.model.DebtRecord.DebtType;
import com.sad.model.baseCode.BusinessType;
import com.sad.web.action.MoneyCommonAction;

/**
 * 债务归还管理
 */
public class DebtReturnAction extends MoneyCommonAction {

	private DebtDao debtDao;

	public String search() {
		DebtRecord debtRecord = entityDao.get(DebtRecord.class, getLong("debtRecordId"));

		OqlBuilder<DebtReturnRecord> query = OqlBuilder.from(DebtReturnRecord.class, "debtReturnRecord");
		query.where("debtReturnRecord.debtRecord =:debtRecord", debtRecord);
		query.orderBy("debtReturnRecord.returnOn");
		put("debtReturnRecords", entityDao.search(query));
		put("debtRecord", debtRecord);
		return forward();
	}

	public String edit() {
		return forward();
	}

	public String addInPay() {
		DebtReturnRecord debtReturnRecord = populateEntity(DebtReturnRecord.class, "debtReturnRecord");
		DebtRecord debtRecord = entityDao.get(DebtRecord.class, debtReturnRecord.getDebtRecord().getId());

		if (debtReturnRecord.getId() != null && debtReturnRecord.getInPayRecord() != null) {
			put("record", debtReturnRecord.getInPayRecord());
		} else {
			IncomePaymentRecord record = new IncomePaymentRecord();
			record.setCreateOn(debtReturnRecord.getReturnOn());
			record.setName(debtRecord.getName());
			record.setAmount(debtReturnRecord.getAmount());
			if (debtRecord.getDebtType().equals(DebtType.borrowIn)) {
				record.getType().setBusinessType(entityDao.get(BusinessType.class, BusinessType.outlay));
			} else {
				record.getType().setBusinessType(entityDao.get(BusinessType.class, BusinessType.income));
			}
			record.setRemark(debtRecord.getDebtUserName() + " 归还");
			put("record", record);
		}
		addBaseCode("businessTypes", BusinessType.class);
		return forward();
	}

	public String save() {
		IncomePaymentRecord inPayRecord = populateEntity(IncomePaymentRecord.class, "record");
		DebtReturnRecord debtReturnRecord = populateEntity(DebtReturnRecord.class, "debtReturnRecord");
		DebtRecord debtRecord = entityDao.get(DebtRecord.class, debtReturnRecord.getDebtRecord().getId());

		debtDao.saveDebtReturn(debtReturnRecord, debtRecord, inPayRecord);
		return redirect("search", "保存成功", "debtRecordId=" + debtReturnRecord.getDebtRecord().getId());
	}

	public String remove() {
		Long[] debtReturnRecordIds = StrUtils.splitToLong(get("debtReturnRecordIds"));
		List<DebtReturnRecord> returnRecords = entityDao.get(DebtReturnRecord.class, debtReturnRecordIds);
		DebtRecord debtRecord = entityDao.get(DebtRecord.class, getLong("debtRecordId"));

		debtDao.removeDebtReturn(returnRecords, debtRecord);
		return redirect("search", "保存成功", "debtRecordId=" + getLong("debtRecordId"));
	}

	public void setDebtDao(DebtDao debtDao) {
		this.debtDao = debtDao;
	}
}
