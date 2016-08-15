package com.sad.service.baseCode;

import java.util.List;

import com.sad.model.baseCode.BaseCode;

public interface BaseCodeService {

	public <T extends BaseCode> List<T> getCodes(Class<T> codeClass);

}
