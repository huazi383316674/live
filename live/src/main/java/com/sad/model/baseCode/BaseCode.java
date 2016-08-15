package com.sad.model.baseCode;

import javax.persistence.MappedSuperclass;
import javax.validation.constraints.NotNull;

import org.beangle.model.pojo.LongIdObject;

@MappedSuperclass
public class BaseCode extends LongIdObject {

	private static final long serialVersionUID = 1L;

	@NotNull
	public String code;

	@NotNull
	public String name;

	public String remark;

	public boolean enable;

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public boolean isEnable() {
		return enable;
	}

	public void setEnable(boolean enable) {
		this.enable = enable;
	}
}
