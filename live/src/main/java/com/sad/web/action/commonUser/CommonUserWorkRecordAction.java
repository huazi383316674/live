package com.sad.web.action.commonUser;

import java.util.Date;

import org.beangle.ems.web.action.SecurityActionSupport;

import com.sad.util.calendar.CalendarUtils;

/**
 * 
 */
public class CommonUserWorkRecordAction extends SecurityActionSupport {

	public String index() {
		put("nowDate", new Date());
		return forward();
	}

	public String search() {
		// 根据“年-月”字符串得到年月
		Date date = getDate("nowDate");

		Date[] datesByWeek = CalendarUtils.getDatesByWeek(date);
		//List<CommonUser> commonUsers = getComonUsers();
		put("datesByWeek", datesByWeek);
		//put("commonUsers", commonUsers);
		put("nowWeekDay", CalendarUtils.getWeekDayByDate(date));
		return forward();
	}

	public String form() {
		return forward();
	}
}
