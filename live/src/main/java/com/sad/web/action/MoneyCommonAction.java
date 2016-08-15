package com.sad.web.action;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.Validate;
import org.beangle.ems.web.action.SecurityActionSupport;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.baseCode.BaseCode;
import com.sad.model.baseCode.IncomePaymentType;
import com.sad.service.baseCode.BaseCodeService;

public class MoneyCommonAction extends SecurityActionSupport {

	private BaseCodeService baseCodeService;

	protected void addBaseCode(String key, Class<? extends BaseCode> clazz) {
		Validate.notEmpty(key);
		put(key, baseCodeService.getCodes(clazz));
	}

	public String getIncomePaymentTypes() {
		if (getLong("businessTypeId") != null) {
			OqlBuilder<IncomePaymentType> query = OqlBuilder.from(IncomePaymentType.class, "type");
			query.where("type.businessType.id =:businessTypeId", getLong("businessTypeId"));
			query.orderBy("type.code");
			put("types", entityDao.search(query));
		}
		return forward("/com/sad/web/action/common/json_incomePaymentTypes");
	}

	public void initInPaysByMonth(String yearMonth) {
		String hqlQuery = "select to_char(r.createOn, 'dd') "
		        + ", (select sum(r1.amount) from com.sad.model.IncomePaymentRecord r1 where r1.type.businessType.id =1 and r.createOn = r1.createOn and r1.user.id =:userId) "
		        + ", (select sum(r1.amount) from com.sad.model.IncomePaymentRecord r1 where r1.type.businessType.id =2 and r.createOn = r1.createOn and r1.user.id =:userId) "
		        + "from com.sad.model.IncomePaymentRecord r where to_char(r.createOn, 'yyyy-MM') =:yearMonth and r.user.id =:userId "
		        + "group by r.createOn order by r.createOn";

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", getUserId());
		params.put("yearMonth", yearMonth);
		List<Object[]> objsList = entityDao.searchHQLQuery(hqlQuery, params);

		Map<String, Float> incomeMap = new HashMap<String, Float>();
		Map<String, Float> paymentMap = new HashMap<String, Float>();
		for (Object[] objs : objsList) {
			if (objs[1] != null) {
				incomeMap.put(objs[0].toString(), Float.valueOf(objs[1].toString()));
			}
			if (objs[2] != null) {
				paymentMap.put(objs[0].toString(), Float.valueOf(objs[2].toString()));
			}
		}
		put("incomeMap", incomeMap);
		put("paymentMap", paymentMap);
	}

	public void setBaseCodeService(BaseCodeService baseCodeService) {
		this.baseCodeService = baseCodeService;
	}
}
