package com.sad.model;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.validation.constraints.NotNull;

import org.beangle.ems.security.User;
import org.beangle.model.pojo.LongIdObject;

/**
 * 节日(生日)提醒
 */
@Entity
public class HolidayRemind extends LongIdObject {

	private static final long serialVersionUID = 1L;

	/** 名称 */
	@NotNull
	private String name;

	/** 年 */
	private Integer year;

	/** 月 */
	private Integer month;

	/** 日 */
	private Integer day;

	/** 是否农历 */
	@NotNull
	private boolean lunar;

	/** 农历日期 */
	private String lunarDate;

	/** 用户 */
	private User user;

	/** 节日类型 */
	@NotNull
	@Enumerated(EnumType.STRING)
	private HolidayType holidayType;

	public static enum HolidayType {
		holiday("节日"), birthday("生日"), memorialDay("纪念日");

		private String fullName;

		private HolidayType() {
		}

		public String getEngName() {
			return this.name();
		}

		private HolidayType(String fullName) {
			this.fullName = fullName;
		}

		public String getFullName() {
			return this.fullName;
		}

		public static HolidayType getHolidayType(String typeName) {
			for (HolidayType holidayType : HolidayType.values()) {
				if (holidayType.name().equals(typeName)) return holidayType;
			}
			return null;
		}
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isLunar() {
		return lunar;
	}

	public void setLunar(boolean lunar) {
		this.lunar = lunar;
	}

	public String getLunarDate() {
		return lunarDate;
	}

	public void setLunarDate(String lunarDate) {
		this.lunarDate = lunarDate;
	}

	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}

	public Integer getMonth() {
		return month;
	}

	public void setMonth(Integer month) {
		this.month = month;
	}

	public Integer getDay() {
		return day;
	}

	public void setDay(Integer day) {
		this.day = day;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public HolidayType getHolidayType() {
		return holidayType;
	}

	public void setHolidayType(HolidayType holidayType) {
		this.holidayType = holidayType;
	}
}
