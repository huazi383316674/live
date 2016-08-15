package com.sad.web.action.commonUser;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.beangle.commons.lang.StrUtils;

import com.sad.model.CommonUser;
import com.sad.model.baseCode.BusinessType;
import com.sad.web.action.MoneyCommonAction;

/**
 * 公共用户管理
 */
@SuppressWarnings("unchecked")
public class CommonUserAction extends MoneyCommonAction {

	public String search() {
		List<CommonUser> commonUsers = search(getQueryBuilder());
		put(getShortName() + "s", commonUsers);

		loadUsersAmount(commonUsers);
		return forward();
	}

	public String isOpen() {
		Long[] commonUserIds = StrUtils.splitToLong(get("commonUserIds"));
		List<CommonUser> commonUsers = entityDao.get(CommonUser.class, commonUserIds);

		boolean isOpen = getBool("isOpen");
		for (CommonUser commonUser : commonUsers) {
			commonUser.setEnable(isOpen);
		}
		entityDao.saveOrUpdate(commonUsers);
		return redirect("search", "操作成功");
	}

	private void loadUsersAmount(List<CommonUser> commonUsers) {
		if (CollectionUtils.isEmpty(commonUsers)) return;

		Long[] userIds = new Long[commonUsers.size()];
		for (int i = 0; i < commonUsers.size(); i++) {
			userIds[i] = commonUsers.get(i).getId();
		}

		StringBuilder hql = new StringBuilder();
		hql
		        .append(
		                "select consume.commonUser.id, (select sum(consume1.amount) from com.sad.model.CommonUserConsume consume1 ")
		        .append(
		                "where consume1.commonUser.id = consume.commonUser.id and consume1.businessType.id =:income) ")

		        .append(", (select sum(consume2.amount) from com.sad.model.CommonUserConsume consume2 ")

		        .append(
		                "where consume2.commonUser.id = consume.commonUser.id and consume2.businessType.id =:outlay) ")
		        .append(
		                "from com.sad.model.CommonUserConsume consume where consume.commonUser.id in (:userIds) ")

		        .append("group by consume.commonUser.id");

		Map<String, Object> params = new HashMap<String, Object>();
		params.put("income", BusinessType.income);
		params.put("outlay", BusinessType.outlay);
		params.put("userIds", userIds);
		List<Object[]> objects = entityDao.searchHQLQuery(hql.toString(), params);

		Map<String, Float> amountMap = new HashMap<String, Float>();
		for (Object[] object : objects) {
			float income = 0;
			float outlay = 0;
			if (object[1] != null) {
				income = Float.valueOf(object[1].toString());
			}
			if (object[2] != null) {
				outlay = Float.valueOf(object[2].toString());
			}
			amountMap.put(object[0].toString(), income - outlay);
		}
		put("amountMap", amountMap);
	}

	protected String getEntityName() {
		return CommonUser.class.getName();
	}
}
