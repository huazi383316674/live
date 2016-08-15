package com.sad.service.baseCode.impl;

import java.util.List;

import org.beangle.model.persist.impl.BaseServiceImpl;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.baseCode.BaseCode;
import com.sad.service.baseCode.BaseCodeService;

public class BaseCodeServiceImpl extends BaseServiceImpl implements BaseCodeService {

	public <T extends BaseCode> List<T> getCodes(Class<T> codeClass) {
		OqlBuilder<T> query = OqlBuilder.from(codeClass, "basecode");
		query.where("basecode.enable = true");
		query.orderBy("basecode.code");
		return entityDao.search(query);
	}
}
