package com.sad.service.other.impl;

import java.util.List;

import org.beangle.model.persist.impl.BaseServiceImpl;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.HolidayRemind;
import com.sad.service.other.HolidayRemindService;

public class HolidayRemindServiceImpl extends BaseServiceImpl implements HolidayRemindService {

	public List<HolidayRemind> getHolidays(int month, Long userId) {
		OqlBuilder<HolidayRemind> query = OqlBuilder.from(HolidayRemind.class, "holiday");
		query.where("holiday.month =:month", month);
		query.where("holiday.user is null or holiday.user.id =:userId", userId);
		query.orderBy("holiday.day");
		return entityDao.search(query);
	}

	public List<HolidayRemind> getLunarHolidays(Long userId) {
		OqlBuilder<HolidayRemind> query = OqlBuilder.from(HolidayRemind.class, "holiday");
		query.where("holiday.lunar =true");
		query.where("holiday.user is null or holiday.user.id =:userId", userId);
		return entityDao.search(query);
	}
}
