package com.sad.model.suggest;

import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.validation.constraints.NotNull;

import org.beangle.commons.collection.CollectUtils;
import org.beangle.commons.comparators.PropertyComparator;
import org.beangle.ems.security.User;
import org.beangle.model.pojo.LongIdObject;

/**
 * 用户意见
 */
@Entity(name = "com.sad.model.suggest.Suggest")
public class Suggest extends LongIdObject {

	private static final long serialVersionUID = 1L;

	/** 编号 */
	@NotNull
	private String no;

	/** 发起人/提出人 */
	@NotNull
	@ManyToOne(fetch = FetchType.LAZY)
	private User speaker;

	/** 意见内容 */
	@NotNull
	private String content;

	/** 一級模块名称 */
	@NotNull
	private String firstModule;

	/** 二級模块名称 */
	private String secondModule;

	/** 创建时间 */
	@NotNull
	private Date createdAt;

	/** 修改时间 */
	private Date updatedAt;

	/** 预解决时间 */
	private Date predictHandleAt;

	/** 处理类别 */
	@NotNull
	@ManyToOne(fetch = FetchType.LAZY)
	private SuggestHandleType handleType;

	/** 指派给 */
	@ManyToOne(fetch = FetchType.LAZY)
	private User appointUser;

	/** 备注 */
	private String remark;

	/** 是否新需求 */
	private Boolean newRequire;

	/** 是否通过 */
	private Boolean passed;

	/** 跟踪记录 */
	@OneToMany(mappedBy = "suggest", orphanRemoval = true, targetEntity = SuggestTail.class, cascade = { CascadeType.ALL })
	private List<SuggestTail> suggestTails = CollectUtils.newArrayList();

	/** 附件 */
	@OneToMany(mappedBy = "suggest", orphanRemoval = true, targetEntity = SuggestAttachment.class, cascade = { CascadeType.ALL })
	private List<SuggestAttachment> suggestAttachments = CollectUtils.newArrayList();

	public String getNo() {
		return no;
	}

	public void setNo(String no) {
		this.no = no;
	}

	public User getSpeaker() {
		return speaker;
	}

	public void setSpeaker(User speaker) {
		this.speaker = speaker;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getFirstModule() {
		return firstModule;
	}

	public void setFirstModule(String firstModule) {
		this.firstModule = firstModule;
	}

	public String getSecondModule() {
		return secondModule;
	}

	public void setSecondModule(String secondModule) {
		this.secondModule = secondModule;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getPredictHandleAt() {
		return predictHandleAt;
	}

	public void setPredictHandleAt(Date predictHandleAt) {
		this.predictHandleAt = predictHandleAt;
	}

	public SuggestHandleType getHandleType() {
		return handleType;
	}

	public void setHandleType(SuggestHandleType handleType) {
		this.handleType = handleType;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Boolean getNewRequire() {
		return newRequire;
	}

	public void setNewRequire(Boolean newRequire) {
		this.newRequire = newRequire;
	}

	public Boolean getPassed() {
		return passed;
	}

	public void setPassed(Boolean passed) {
		this.passed = passed;
	}

	public User getAppointUser() {
		return appointUser;
	}

	public void setAppointUser(User appointUser) {
		this.appointUser = appointUser;
	}

	public List<SuggestTail> getSuggestTails() {
		if (suggestTails != null) {
			Collections.sort(suggestTails, new PropertyComparator<SuggestTail>("createdAt desc"));
		}
		return suggestTails;
	}

	public void setSuggestTails(List<SuggestTail> suggestTails) {
		this.suggestTails = suggestTails;
	}

	public List<SuggestAttachment> getSuggestAttachments() {
		return suggestAttachments;
	}

	public void setSuggestAttachments(List<SuggestAttachment> suggestAttachments) {
		this.suggestAttachments = suggestAttachments;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

}
