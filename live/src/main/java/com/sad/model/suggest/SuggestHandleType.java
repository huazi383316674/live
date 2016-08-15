package com.sad.model.suggest;

import javax.persistence.Entity;

import com.sad.model.baseCode.BaseCode;

/**
 * 意见处理类型
 */
@Entity(name = "com.sad.model.suggest.SuggestHandleType")
public class SuggestHandleType extends BaseCode {

	private static final long serialVersionUID = 1L;

	public static final Long unResolved = 1L;
	public static final Long resolved = 2L;
	public static final Long noResolved = 3L;

	public SuggestHandleType() {
	}

	public SuggestHandleType(Long id) {
		this.id = id;
	}
}
