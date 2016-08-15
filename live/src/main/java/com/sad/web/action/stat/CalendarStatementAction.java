package com.sad.web.action.stat;

import java.util.Date;

import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.IncomePaymentRecord;
import com.sad.service.other.HolidayRemindService;
import com.sad.util.calendar.CalendarUtils;
import com.sad.web.action.MoneyCommonAction;

/**
 * 收支日历报表
 */
public class CalendarStatementAction extends MoneyCommonAction {

	private HolidayRemindService holidayRemindService;

	public String index() {
		put("nowDate", new Date());
		return forward();
	}

	public String search() {
		// 根据“年-月”字符串得到年月
		String yearMonth = get("yearMonth");
		int year = Integer.valueOf(yearMonth.substring(0, 4));
		int month = Integer.valueOf(yearMonth.substring(yearMonth.indexOf("-") + 1));

		put("dayOfWeek", CalendarUtils.getDayOfWeek(year, month)); // 得到当月第一天星期几
		put("days", CalendarUtils.getDaysByMonth(year, month)); // 得到当月多少天

		if (CalendarUtils.validateSameYearMonth(year, month, new Date())) {
			put("dateNo", CalendarUtils.getDateNo(new Date())); // 得到今天多少号
		}

		// 得到农历日期
		put("lunarCalMap", CalendarUtils.getLunarCaledarsByMonth(year, month));

		// 统计当月情况(日期、日、收入总额、支出总额)
		initInPaysByMonth(yearMonth);
		// 得到当月的节假日
		initHolidays(month);

		return forward();
	}

	public String loadIncomePaymentRecords() {
		String yearMonth = get("yearMonth");
		String day = get("day");

		OqlBuilder<IncomePaymentRecord> query = OqlBuilder.from(IncomePaymentRecord.class, "record");
		query.where("to_char(record.createOn, 'yyyy-MM-dd') =:date", CalendarUtils.buildStrDate(yearMonth, day));
		query.orderBy("record.createOn");
		put("records", entityDao.search(query));
		return forward("json_records");
	}

	private void initHolidays(int month) {
		put("holidays", holidayRemindService.getHolidays(month, getUserId()));
		put("lunarHolidays", holidayRemindService.getLunarHolidays(getUserId()));
	}

	public void setHolidayRemindService(HolidayRemindService holidayRemindService) {
		this.holidayRemindService = holidayRemindService;
	}
}
