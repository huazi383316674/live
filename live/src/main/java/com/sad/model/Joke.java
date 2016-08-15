package com.sad.model;

import javax.persistence.Entity;
import javax.validation.constraints.NotNull;

import org.beangle.ems.security.User;
import org.beangle.model.pojo.LongIdObject;

/**
 * 幽默笑话（轻松一刻）
 */
@Entity
public class Joke extends LongIdObject {

	private static final long serialVersionUID = 1L;

	private String title;

	@NotNull
	private String content;

	private User user;

	public Joke() {
	}

	public Joke(Long id, String title, String content, User user) {
		this.id = id;
		this.title = title;
		this.content = content;
		this.user = user;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

}
