package com.sad.model.suggest;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;

import org.beangle.ems.security.User;
import org.beangle.model.pojo.LongIdObject;

/**
 * 用户意见跟踪记录
 */
@Entity(name = "com.sad.model.suggest.SuggestTail")
public class SuggestTail extends LongIdObject {

	private static final long serialVersionUID = 1L;

	/** 用户意见 */
	@ManyToOne(fetch = FetchType.LAZY)
	private Suggest suggest;

	/** 跟踪时间 */
	private Date createdAt;

	/** 跟踪用户 */
	@ManyToOne(fetch = FetchType.LAZY)
	private User tailUser;

	/** 跟踪意见 */
	private String tailExplain;

	/** 处理类别 */
	@ManyToOne(fetch = FetchType.LAZY)
	private SuggestHandleType handleType;

	/** 指派给 */
	@ManyToOne(fetch = FetchType.LAZY)
	private User appointUser;

	public SuggestHandleType getHandleType() {
		return handleType;
	}

	public void setHandleType(SuggestHandleType handleType) {
		this.handleType = handleType;
	}

	public User getAppointUser() {
		return appointUser;
	}

	public void setAppointUser(User appointUser) {
		this.appointUser = appointUser;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public User getTailUser() {
		return tailUser;
	}

	public void setTailUser(User tailUser) {
		this.tailUser = tailUser;
	}

	public String getTailExplain() {
		return tailExplain;
	}

	public void setTailExplain(String tailExplain) {
		this.tailExplain = tailExplain;
	}

	public Suggest getSuggest() {
		return suggest;
	}

	public void setSuggest(Suggest suggest) {
		this.suggest = suggest;
	}

}
