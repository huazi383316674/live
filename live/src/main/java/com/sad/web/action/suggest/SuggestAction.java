package com.sad.web.action.suggest;

import java.sql.Date;
import java.util.List;

import org.beangle.commons.lang.StrUtils;
import org.beangle.ems.security.model.UserBean;

import com.sad.model.suggest.Suggest;
import com.sad.model.suggest.SuggestHandleType;
import com.sad.model.suggest.SuggestTail;

public class SuggestAction extends SuggestForManagerAction {

	/**
	 * 指派任务
	 */
	public String assign() {
		List<Suggest> suggests = entityDao.get(Suggest.class, StrUtils.splitToLong(get("suggestIds")));

		Long appointUserId = getLong("appointUserId");
		Date predictHandleOn = getDate("predictHandleAt");
		for (Suggest suggest : suggests) {
			if (appointUserId != null) suggest.setAppointUser(new UserBean(appointUserId));
			if (predictHandleOn != null) suggest.setPredictHandleAt(predictHandleOn);
		}
		entityDao.saveOrUpdate(suggests);
		return redirect("search", "操作成功");
	}

	/**
	 * 添加跟踪处理意见
	 */
	public String addSuggestTail() {
		Suggest suggest = entityDao.get(Suggest.class, getEntityId("suggest"));

		SuggestTail suggestTail = new SuggestTail();
		suggestTail.setAppointUser(new UserBean(getLong("appointUserId")));
		suggestTail.setCreatedAt(new java.util.Date());
		suggestTail.setHandleType(new SuggestHandleType(getLong("handleTypeId")));
		suggestTail.setTailExplain(get("tailExplain"));
		suggestTail.setSuggest(suggest);
		suggestTail.setTailUser(new UserBean(getUserId()));

		suggest.getSuggestTails().add(suggestTail);
		entityDao.saveOrUpdate(suggest);
		suggestService.syncUpdateSuggest(suggest, suggestTail);
		return redirect("search", "操作成功!");
	}

	public String remove() {
		List<Suggest> suggests = entityDao.get(Suggest.class, getEntityIds("suggest"));

		entityDao.remove(suggests);
		return redirect("search", "删除成功!");
	}
}
