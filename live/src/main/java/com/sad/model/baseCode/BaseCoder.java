package com.sad.model.baseCode;

import javax.persistence.Entity;
import javax.persistence.Table;

import org.beangle.model.pojo.LongIdObject;

@Table(name = "A_BASE_CODERS")
@Entity(name = "com.sad.model.baseCode.BaseCoder")
public class BaseCoder extends LongIdObject {

	private static final long serialVersionUID = 1L;

	private String name;
	private String engName;
	private String className;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getEngName() {
		return engName;
	}

	public void setEngName(String engName) {
		this.engName = engName;
	}

	public String getClassName() {
		return className;
	}

	public void setClassName(String className) {
		this.className = className;
	}

}
