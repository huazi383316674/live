package com.sad.model.suggest;

import java.util.Date;

import javax.persistence.Entity;

import org.beangle.ems.security.User;
import org.beangle.model.pojo.LongIdObject;

/**
 * 用户意见附件文档
 */
@Entity
public class SuggestAttachment extends LongIdObject {

	private static final long serialVersionUID = 1L;

	/** 附件名称 */
	private String name;

	/** 文件名 */
	private String fileName;

	/** 创建时间 */
	private Date createdAt;

	/** 上传人 */
	private User uploader;

	/** 对应的用户意见 */
	private Suggest suggest;

	/** 对应的跟踪意见 */
	private SuggestTail suggestTail;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public User getUploader() {
		return uploader;
	}

	public void setUploader(User uploader) {
		this.uploader = uploader;
	}

	public Suggest getSuggest() {
		return suggest;
	}

	public void setSuggest(Suggest suggest) {
		this.suggest = suggest;
	}

	public SuggestTail getSuggestTail() {
		return suggestTail;
	}

	public void setSuggestTail(SuggestTail suggestTail) {
		this.suggestTail = suggestTail;
	}
}
