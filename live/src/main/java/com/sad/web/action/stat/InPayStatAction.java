package com.sad.web.action.stat;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.baseCode.BusinessType;
import com.sad.model.baseCode.IncomePaymentType;
import com.sad.util.calendar.CalendarUtils;
import com.sad.web.action.MoneyCommonAction;

/**
 * 收支统计管理
 */
public class InPayStatAction extends MoneyCommonAction {

	public String index() {
		return forward();
	}

	public String stat_month() {
		String yearMonth = get("yearMonth");
		if (StringUtils.isBlank(yearMonth)) {
			yearMonth = CalendarUtils.buildYearMonthByDate(new Date());
		}

		initInPaysByMonth(yearMonth);
		put("days", CalendarUtils.getDaysByMonth(yearMonth));
		put("yearMonth", yearMonth);

		put("YmaxValue", getInteger("YmaxValue"));
		put("YgapValue", getInteger("YgapValue"));
		put("fontSize", getInteger("fontSize"));
		put("reportType", get("reportType"));
		return forward();
	}

	/**
	 * 按类型统计
	 */
	public String stat_type() {
		String yearMonth = get("yearMonth");

		if (StringUtils.isBlank(yearMonth)) {
			yearMonth = CalendarUtils.buildYearMonthByDate(new Date());
		}

		initInpayByBussinessType(yearMonth);
		put("yearMonth", yearMonth);
		return forward();
	}

	private void initInpayByBussinessType(String yearMonth) {
		String hqlQuery = "select r.type.id, sum(r.amount) from com.sad.model.IncomePaymentRecord r where to_char(r.createOn, 'yyyy-MM') =:yearMonth "
		        + "and r.user.id =:userId and r.type.businessType.id =:businessTypeId group by r.type.id";

		// 支出
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", getUserId());
		params.put("businessTypeId", BusinessType.outlay);
		params.put("yearMonth", yearMonth);
		List<Object[]> objsList = entityDao.searchHQLQuery(hqlQuery, params);

		Map<String, Float> outlayMap = new TreeMap<String, Float>();
		List<Long> outlayTypeIds = new ArrayList<Long>();
		for (Object[] objs : objsList) {
			outlayMap.put(objs[0].toString(), Float.valueOf(objs[1].toString()));
			outlayTypeIds.add(Long.valueOf(objs[0].toString()));
		}
		put("outlayMap", outlayMap);

		if (CollectionUtils.isNotEmpty(outlayTypeIds)) {
			OqlBuilder<IncomePaymentType> outlayQuery = OqlBuilder.from(IncomePaymentType.class, "inPayType");
			outlayQuery.where("inPayType.id in (:inPayTypeIds)", outlayTypeIds);
			outlayQuery.orderBy("inPayType.code");
			put("outlayTypes", entityDao.search(outlayQuery));
		}

		// 收入
		Map<String, Object> incomeParams = new HashMap<String, Object>();
		incomeParams.put("userId", getUserId());
		incomeParams.put("businessTypeId", BusinessType.income);
		incomeParams.put("yearMonth", yearMonth);
		List<Object[]> incomeObjList = entityDao.searchHQLQuery(hqlQuery, incomeParams);

		Map<String, Float> incomeMap = new TreeMap<String, Float>();
		List<Long> incomeTypeIds = new ArrayList<Long>();
		for (Object[] objs : incomeObjList) {
			incomeMap.put(objs[0].toString(), Float.valueOf(objs[1].toString()));
			incomeTypeIds.add(Long.valueOf(objs[0].toString()));
		}
		put("incomeMap", incomeMap);

		if (CollectionUtils.isNotEmpty(incomeTypeIds)) {
			OqlBuilder<IncomePaymentType> incomeQuery = OqlBuilder.from(IncomePaymentType.class, "inPayType");
			incomeQuery.where("inPayType.id in (:inPayTypeIds)", incomeTypeIds);
			incomeQuery.orderBy("inPayType.code");
			put("incomeTypes", entityDao.search(incomeQuery));
		}
	}
}
