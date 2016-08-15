package com.sad.service.suggest.impl;

import java.util.Date;

import org.beangle.ems.security.User;
import org.beangle.model.persist.impl.BaseServiceImpl;

import com.sad.model.suggest.Suggest;
import com.sad.model.suggest.SuggestHandleType;
import com.sad.model.suggest.SuggestTail;
import com.sad.service.suggest.SuggestService;

public class SuggestServiceImpl extends BaseServiceImpl implements SuggestService {

	public void syncUpdateSuggest(Suggest suggest, SuggestTail suggestTail) {
		suggest.setUpdatedAt(suggestTail.getCreatedAt());
		suggest.setHandleType(suggestTail.getHandleType());
		suggest.setAppointUser(suggestTail.getAppointUser());
		entityDao.saveOrUpdate(suggest);
	}

	@Deprecated
	public void updateSuggest(Suggest suggest, SuggestHandleType handleType, User appointUser) {
		suggest.setAppointUser(appointUser);
		suggest.setHandleType(handleType);
		suggest.setUpdatedAt(new Date());
	}

}
