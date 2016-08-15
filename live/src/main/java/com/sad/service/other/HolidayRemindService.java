package com.sad.service.other;

import java.util.List;

import com.sad.model.HolidayRemind;

public interface HolidayRemindService {

	public List<HolidayRemind> getHolidays(int month, Long userId);

	public List<HolidayRemind> getLunarHolidays(Long userId);
}
