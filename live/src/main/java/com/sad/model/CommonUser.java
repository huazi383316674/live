package com.sad.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;

import org.beangle.model.pojo.LongIdObject;

/**
 * 公共用户管理
 */
@Entity
public class CommonUser extends LongIdObject {

	private static final long serialVersionUID = 1L;

	@NotNull
	private String name;

	@NotNull
	private Date createOn;

	@NotNull
	private boolean enable;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public boolean isEnable() {
		return enable;
	}

	public void setEnable(boolean enable) {
		this.enable = enable;
	}

	public Date getCreateOn() {
		return createOn;
	}

	public void setCreateOn(Date createOn) {
		this.createOn = createOn;
	}

}
