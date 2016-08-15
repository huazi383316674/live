package com.sad.web.action.suggest;

import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.beangle.commons.collection.Order;
import org.beangle.ems.security.User;
import org.beangle.ems.security.model.UserBean;
import org.beangle.ems.web.action.SecurityActionSupport;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.suggest.Suggest;
import com.sad.model.suggest.SuggestHandleType;
import com.sad.model.suggest.SuggestTail;
import com.sad.service.suggest.SuggestGenCodeService;
import com.sad.service.suggest.SuggestService;

/**
 * 意见管理（针对最终用户）
 */
public class SuggestForUserAction extends SecurityActionSupport {

	protected SuggestGenCodeService suggestGenCodeService;
	protected SuggestService suggestService;

	public String index() {
		OqlBuilder<String> firstMQuery = OqlBuilder.from(Suggest.class.getName(), "suggest");
		firstMQuery.groupBy("suggest.firstModule").select("suggest.firstModule");
		firstMQuery.orderBy("suggest.firstModule");
		put("firstModules", entityDao.search(firstMQuery));

		addBaseCode("handleTypes", SuggestHandleType.class);
		return forward();
	}

	public String search() {
		put("suggests", entityDao.search(buildSuggestQuery()));
		return forward();
	}

	public String edit() {
		addBaseCode("handleTypes", SuggestHandleType.class);

		Long suggestId = getEntityId("suggest");
		if (suggestId != null) {
			put("suggest", entityDao.get(Suggest.class, suggestId));
		}
		return forward();
	}

	public String save() {
		Suggest suggest = populateEntity(Suggest.class, "suggest");
		if (suggest.getId() == null) {
			suggest.setCreatedAt(new Date());
			suggest.setHandleType(new SuggestHandleType(SuggestHandleType.unResolved));
			suggest.setSpeaker(new UserBean(getUserId()));
			suggest.setNo(suggestGenCodeService.generate());
		}
		suggest.setUpdatedAt(new Date());
		entityDao.saveOrUpdate(suggest);
		return redirect("search", "操作成功");
	}

	public String info() {
		put("suggest", entityDao.get(Suggest.class, getEntityId("suggest")));
		addBaseCode("handleTypes", SuggestHandleType.class);
		return forward();
	}

	public String remove() {
		List<Suggest> suggests = entityDao.get(Suggest.class, getEntityIds("suggest"));

		for (Suggest suggest : suggests) {
			if (!suggest.getSpeaker().getId().equals(getUserId())) return redirect("search",
			        "删除失败,无法删除别人报告的意见!");
		}

		entityDao.remove(suggests);
		return redirect("search", "删除成功!");
	}

	/**
	 * 添加跟踪处理意见
	 */
	public String addSuggestTail() {
		Suggest suggest = entityDao.get(Suggest.class, getEntityId("suggest"));

		SuggestTail suggestTail = new SuggestTail();
		suggestTail.setCreatedAt(new Date());
		suggestTail.setHandleType(new SuggestHandleType(getLong("handleTypeId")));
		suggestTail.setTailExplain(get("tailExplain"));
		suggestTail.setSuggest(suggest);
		suggestTail.setTailUser(new UserBean(getUserId()));

		suggest.getSuggestTails().add(suggestTail);
		entityDao.saveOrUpdate(suggest);
		suggestService.syncUpdateSuggest(suggest, suggestTail);
		return redirect("search", "操作成功!");
	}

	private OqlBuilder<Suggest> buildSuggestQuery() {
		OqlBuilder<Suggest> query = OqlBuilder.from(Suggest.class, "suggest");
		populateConditions(query, "suggest.id");

		if (StringUtils.isNotBlank(get("createdStartAt"))) {
			query.where("to_char(suggest.createdAt,'yyyy-MM-dd') >=:createdStartAt", get("createdStartAt"));
		}
		if (StringUtils.isNotBlank(get("createdEndAt"))) {
			query.where("to_char(suggest.createdAt,'yyyy-MM-dd') <=:createdEndAt", get("createdEndAt"));
		}
		if (StringUtils.isNotBlank(get("updatedStartAt"))) {
			query.where("to_char(suggest.createdAt,'yyyy-MM-dd') >=:updatedStartAt", get("updatedStartAt"));
		}
		if (StringUtils.isNotBlank(get("updatedEndAt"))) {
			query.where("to_char(suggest.createdAt,'yyyy-MM-dd') <=:updatedEndAt", get("updatedEndAt"));
		}

		if (StringUtils.isBlank(get(Order.ORDER_STR))) {
			// query.orderBy("record.createOn desc");
		} else {
			query.orderBy(get(Order.ORDER_STR));
		}
		query.limit(getPageLimit());
		return query;
	}

	public String searchUserByNameOrFullname() {
		String nameOrFullname = get("term");
		OqlBuilder<User> query = OqlBuilder.from(User.class, "user");
		populateConditions(query);

		if (StringUtils.isNotEmpty(nameOrFullname)) {
			query.where("(user.name like :name or user.fullname like :name)", '%' + nameOrFullname + '%');
		}
		query.where("user.effectiveAt <= :now and (user.invalidAt is null or user.invalidAt >= :now)",
		        new Date());

		query.limit(getPageLimit()).orderBy("user.name");
		put("users", entityDao.search(query));
		return forward("json_users");
	}

	public void setSuggestGenCodeService(SuggestGenCodeService suggestGenCodeService) {
		this.suggestGenCodeService = suggestGenCodeService;
	}

	public void setSuggestService(SuggestService suggestService) {
		this.suggestService = suggestService;
	}

}
