package com.sad.model;

import java.sql.Date;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Size;

import org.beangle.model.pojo.LongIdObject;

/**
 * 公共用户每天工作报告
 */
@Entity
public class CommonUserWorkRecord extends LongIdObject {

	private static final long serialVersionUID = 1L;

	@NotNull
	private CommonUser commonUser;

	@NotNull
	@Size(max = 1000)
	private String content;

	@NotNull
	private Date createOn;

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Date getCreateOn() {
		return createOn;
	}

	public void setCreateOn(Date createOn) {
		this.createOn = createOn;
	}

	public CommonUser getCommonUser() {
		return commonUser;
	}

	public void setCommonUser(CommonUser commonUser) {
		this.commonUser = commonUser;
	}

}
