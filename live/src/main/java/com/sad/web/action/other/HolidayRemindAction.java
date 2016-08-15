package com.sad.web.action.other;

import java.util.Calendar;

import org.apache.commons.lang.StringUtils;
import org.beangle.commons.collection.Order;
import org.beangle.ems.security.User;
import org.beangle.ems.web.action.SecurityActionSupport;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.HolidayRemind;
import com.sad.model.HolidayRemind.HolidayType;
import com.sad.util.calendar.LunarCalendar;

/**
 * 节日提醒
 */
public class HolidayRemindAction extends SecurityActionSupport {

	public String index() {
		return forward();
	}

	public String search() {
		OqlBuilder<HolidayRemind> query = OqlBuilder.from(HolidayRemind.class, "holidayRemind");
		populateConditions(query);
		query.where("holidayRemind.user.id =:userId", getUserId());

		if (StringUtils.isNotBlank(get("holidayType"))) {
			query.where("holidayRemind.holidayType =:holidayType", HolidayType
			        .getHolidayType(get("holidayType")));
		}
		if (StringUtils.isBlank(get(Order.ORDER_STR))) {
			query.orderBy("holidayRemind.year, holidayRemind.month, holidayRemind.day");
		} else {
			query.orderBy(get(Order.ORDER_STR));
		}
		query.limit(getPageLimit());
		put("holidayReminds", entityDao.search(query));
		return forward();
	}

	public String save() {
		Calendar cal = Calendar.getInstance();
		cal.setTime(getDate("holidayDate"));
		int year = cal.get(Calendar.YEAR);
		int month = cal.get(Calendar.MONTH) + 1;
		int day = cal.get(Calendar.DAY_OF_MONTH);

		HolidayRemind holidayRemind = populateEntity(HolidayRemind.class, "holidayRemind");
		holidayRemind.setUser(entityDao.get(User.class, getUserId()));
		holidayRemind.setHolidayType(HolidayType.getHolidayType(get("holidayType")));
		holidayRemind.setYear(year);

		if (holidayRemind.isLunar()) {
			holidayRemind.setLunarDate(new LunarCalendar(year, month, day).toString());
			holidayRemind.setMonth(null);
			holidayRemind.setDay(null);
		} else {
			holidayRemind.setMonth(month);
			holidayRemind.setDay(day);
		}
		entityDao.saveOrUpdate(holidayRemind);
		return redirect("search", "保存成功");
	}

	@Override
	protected String getEntityName() {
		return HolidayRemind.class.getName();
	}
}
