package com.sad.web.action.money;

import org.apache.commons.lang.StringUtils;
import org.beangle.commons.collection.Order;
import org.beangle.commons.lang.StrUtils;
import org.beangle.ems.security.User;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.IncomePaymentRecord;
import com.sad.model.baseCode.BusinessType;
import com.sad.web.action.MoneyCommonAction;

/**
 * 收支清单管理
 */
public class IncomePaymentRecordAction extends MoneyCommonAction {

	public String index() {
		addBaseCode("businessTypes", BusinessType.class);
		return forward();
	}

	public String search() {
		OqlBuilder<IncomePaymentRecord> query = OqlBuilder.from(IncomePaymentRecord.class, "record");
		populateConditions(query);

		if (StringUtils.isNotBlank(get("createMonth"))) {
			query.where("to_char(record.createOn, 'yyyy-MM') =:createMonth", get("createMonth"));
		}
		if (StringUtils.isBlank(get(Order.ORDER_STR))) {
			query.orderBy("record.createOn desc");
		} else {
			query.orderBy(get(Order.ORDER_STR));
		}
		query.limit(getPageLimit());
		put("records", entityDao.search(query));
		return forward();
	}

	public String edit() {
		Long recordId = getLong("recordId");

		if (recordId != null) {
			IncomePaymentRecord record = entityDao.get(IncomePaymentRecord.class, recordId);
			put("record", record);
		}
		addBaseCode("businessTypes", BusinessType.class);
		return forward();
	}

	public String save() {
		IncomePaymentRecord record = populateEntity(IncomePaymentRecord.class, "record");
		record.setUser(entityDao.get(User.class, getUserId()));

		entityDao.saveOrUpdate(record);
		return redirect("search", "保存成功");
	}

	public String remove() {
		Long[] recordIds = StrUtils.splitToLong(get("recordIds"));
		entityDao.remove(entityDao.get(IncomePaymentRecord.class, recordIds));
		return redirect("search", "删除成功");
	}

}
