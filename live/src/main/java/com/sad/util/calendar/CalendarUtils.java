package com.sad.util.calendar;

import java.util.Calendar;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Map;

public class CalendarUtils {

	/**
	 * 根据月份 获取第一天星期几
	 */
	public static int getDayOfWeek(int year, int month) {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.DATE, 1);
		cal.set(Calendar.MONTH, month - 1);
		cal.set(Calendar.YEAR, year);
		return cal.get(Calendar.DAY_OF_WEEK) - 1;
	}

	/**
	 * 得到一个月的天数
	 */
	public static int getDaysByMonth(int year, int month) {
		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, year);
		cal.set(Calendar.MONTH, month - 1);
		return cal.getActualMaximum(Calendar.DATE);
	}

	/**
	 * 得到一个月的天数
	 */
	public static int getDaysByMonth(String yearMonth) {
		int year = Integer.valueOf(yearMonth.substring(0, 4));
		int month = Integer.valueOf(yearMonth.substring(yearMonth.indexOf("-") + 1));
		return getDaysByMonth(year, month);
	}

	/**
	 * 根据日期得到当前是多少号
	 */
	public static int getDateNo(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		return cal.get(Calendar.DATE);
	}

	/**
	 */
	public static boolean validateSameYearMonth(int year, int month, Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int year_ = cal.get(Calendar.YEAR);
		int month_ = cal.get(Calendar.MONTH) + 1;
		if (year != year_ || month != month_) { return false; }
		return true;
	}

	/**
	 * 构建日期字符串
	 */
	public static String buildStrDate(String yearMonth, String day) {
		StringBuffer sb = new StringBuffer(yearMonth).append("-");
		if (day.length() < 2) {
			sb.append("0").append(day);
		} else {
			sb.append(day);
		}
		return sb.toString();
	}

	/**
	 * 构建当前日期的年月
	 */
	public static String buildYearMonthByDate(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int month = cal.get(Calendar.MONTH) + 1;
		if (month < 10) { return cal.get(Calendar.YEAR) + "-0" + month; }
		return cal.get(Calendar.YEAR) + "-" + (cal.get(Calendar.MONTH) + 1);
	}

	/**
	 * 得到当月的农历日期
	 */
	public static Map<String, String> getLunarCaledarsByMonth(int year, int month) {
		int days = getDaysByMonth(year, month);

		Map<String, String> lunarCalMap = new HashMap<String, String>();
		for (int i = 1; i <= days; i++) {
			lunarCalMap.put(String.valueOf(i), getLunarCaledars(year, month, i));
		}
		return lunarCalMap;
	}

	/**
	 * 根据日期得到农历日期
	 */
	public static String getLunarCaledars(int year, int month, int day) {
		Calendar cal = Calendar.getInstance();
		cal.set(year, month - 1, day);
		return new LunarCalendar(cal).toString();
	}

	/**
	 * 得到当前日期的周数
	 */
	public static int getWeekOfYear(Date date) {
		GregorianCalendar gc = new GregorianCalendar();
		gc.setTime(date);
		return gc.get(Calendar.WEEK_OF_YEAR);
	}

	/**
	 * 根据日期得到当前星期所有的日期
	 */
	@SuppressWarnings("deprecation")
	public static Date[] getDatesByWeek(Date date) {
		Date[] dates = new Date[7];

		Calendar cal = Calendar.getInstance();
		cal.set(Calendar.YEAR, date.getYear() + 1900);
		cal.set(Calendar.WEEK_OF_YEAR, getWeekOfYear(date));
		for (int i = 0; i < 7; i++) {
			cal.set(Calendar.DAY_OF_WEEK, cal.getFirstDayOfWeek() + i);
			dates[i] = cal.getTime();
		}
		return dates;
	}

	/**
	 * 得到当前日期为星期几
	 */
	public static Integer getWeekDayByDate(Date date) {
		Calendar cal = Calendar.getInstance();
		cal.setTime(date);
		int w = cal.get(Calendar.DAY_OF_WEEK) - 1;
		return w;
	}

	public static void main(String[] args) {
		Date date = new Date();
		System.out.println(new LunarCalendar(date));
	}
}
