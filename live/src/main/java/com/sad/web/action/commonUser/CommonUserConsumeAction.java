package com.sad.web.action.commonUser;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
import org.beangle.commons.collection.CollectUtils;
import org.beangle.commons.collection.Order;
import org.beangle.commons.lang.StrUtils;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.CommonUser;
import com.sad.model.CommonUserConsume;
import com.sad.model.baseCode.BusinessType;
import com.sad.util.calendar.CalendarUtils;
import com.sad.web.action.MoneyCommonAction;

/**
 * 公共用户消费管理
 */
public class CommonUserConsumeAction extends MoneyCommonAction {

	public String index() {
		put("nowDate", new Date());
		return forward();
	}

	public String search() {
		// 根据“年-月”字符串得到年月
		Date date = getDate("nowDate");

		Date[] datesByWeek = CalendarUtils.getDatesByWeek(date);
		List<CommonUser> commonUsers = getComonUsers();
		put("datesByWeek", datesByWeek);
		put("commonUsers", commonUsers);
		put("nowWeekDay", CalendarUtils.getWeekDayByDate(date));

		StringBuffer selectWhat1 = new StringBuffer();
		for (CommonUser user : commonUsers) {
			selectWhat1
			        .append(
			                ", (select sum(c1.amount) from com.sad.model.CommonUserConsume c1 where c.createOn = c1.createOn and c1.businessType.id=1 and c1.commonUser.id =")
			        .append(user.getId()).append(")");
			selectWhat1
			        .append(
			                ", (select sum(c1.amount) from com.sad.model.CommonUserConsume c1 where c.createOn = c1.createOn and c1.businessType.id=2 and c1.commonUser.id =")
			        .append(user.getId()).append(")");
		}

		String hql1 = "select c.createOn" + selectWhat1.toString()
		        + " from com.sad.model.CommonUserConsume c group by c.createOn";
		put("statList", entityDao.searchHQLQuery(hql1));

		// 总统计
		StringBuffer selectWhat2 = new StringBuffer();
		for (CommonUser user : commonUsers) {
			selectWhat2
			        .append(
			                ", (select sum(c1.amount) from com.sad.model.CommonUserConsume c1 where c1.businessType.id=1 and c1.commonUser.id =")
			        .append(user.getId()).append(")");
			selectWhat2
			        .append(
			                ", (select sum(c1.amount) from com.sad.model.CommonUserConsume c1 where c1.businessType.id=2 and c1.commonUser.id =")
			        .append(user.getId()).append(")");
		}

		String hql2 = "select 1" + selectWhat2.toString() + " from com.sad.model.baseCode.BaseCoder";
		put("totalStats", entityDao.searchHQLQuery(hql2).get(0));

		// 获取总金额
		put("totalMoney", getTotalMoney());

		// 加载平均消费
		if (CollectionUtils.isNotEmpty(commonUsers)) {
			Map<String, String> avgConsumeMap = new HashMap<String, String>();

			StringBuilder hqlQuery = new StringBuilder("select consume.commonUser.id, sum(consume.amount), ");
			hqlQuery
			        .append("(select count(distinct c.createOn) from com.sad.model.CommonUserConsume c where c.commonUser.id = consume.commonUser.id and c.businessType.id =:bTypeId) ");
			hqlQuery
			        .append("from com.sad.model.CommonUserConsume consume where consume.businessType.id =:bTypeId ");
			hqlQuery.append("and consume.commonUser in (:commonUsers) group by consume.commonUser.id");
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("bTypeId", BusinessType.outlay);
			params.put("commonUsers", commonUsers);
			List<Object[]> objectResults = entityDao.searchHQLQuery(hqlQuery.toString(), params);

			for (Object[] objs : objectResults) {
				Double sum = (Double) objs[1];
				Long count = (Long) objs[2];
				avgConsumeMap.put(objs[0].toString(), String.format("%.1f", (sum / count)));
			}
			put("avgConsumeMap", avgConsumeMap);
		}
		return forward();
	}

	/**
	 * 保存
	 * 
	 * @return
	 */
	public String ajaxSave() {
		Long commonUserId = getLong("commonUserId");
		float amount = getFloat("amount");
		Long businessTypeId = getLong("typeId");
		int dateIndex = getInteger("dateIndex");

		Date createAt = CalendarUtils.getDatesByWeek(getDate("nowDate"))[dateIndex];

		CommonUserConsume consume = new CommonUserConsume();
		consume.setAmount(amount);
		consume.setBusinessType(entityDao.get(BusinessType.class, businessTypeId));
		consume.setCommonUser(entityDao.get(CommonUser.class, commonUserId));
		consume.setCreateOn(new java.sql.Date(createAt.getTime()));
		entityDao.saveOrUpdate(consume);

		// 保存后重新统计
		String hql = "select (select sum(c.amount) from com.sad.model.CommonUserConsume c where c.businessType.id=1 and c.commonUser.id =:commonUserId and c.createOn =:createOn), "
		        + "(select sum(c.amount) from com.sad.model.CommonUserConsume c where c.businessType.id=2 and c.commonUser.id =:commonUserId and c.createOn =:createOn)"
		        + " from com.sad.model.baseCode.BaseCoder";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("commonUserId", consume.getCommonUser().getId());
		params.put("createOn", consume.getCreateOn());
		List<Object[]> objs = entityDao.searchHQLQuery(hql, params);

		float income = 0, payment = 0;
		if (objs.get(0)[0] != null) {
			income = Float.valueOf(objs.get(0)[0].toString());
		}
		if (objs.get(0)[1] != null) {
			payment = Float.valueOf(objs.get(0)[1].toString());
		}
		put("income", income);
		put("payment", payment);
		return forward("json_total");
	}

	public String consumes() {
		OqlBuilder<CommonUserConsume> query = OqlBuilder.from(CommonUserConsume.class, "consume");
		populateConditions(query);
		query.orderBy(get(Order.ORDER_STR)).limit(getPageLimit());
		put("consumes", entityDao.search(query));
		put("commonUsers", getComonUsers());
		return forward();
	}

	public String remove() {
		entityDao.remove(entityDao.get(CommonUserConsume.class, StrUtils.splitToLong(get("consume.ids"))));
		return redirect("consumes", "删除成功");
	}

	public String edit() {
		if (getLong("consume.id") != null) {
			put("consume", entityDao.get(CommonUserConsume.class, getLong("consume.id")));
		}
		put("commonUsers", getComonUsers());
		return forward();
	}

	public String save() {
		entityDao.saveOrUpdate(populateEntity(CommonUserConsume.class, "consume"));
		return redirect("consumes", "保存成功");
	}

	/**
	 * 获取公共用户
	 */
	private List<CommonUser> getComonUsers() {
		OqlBuilder<CommonUser> query = OqlBuilder.from(CommonUser.class, "commonUser");
		query.where("commonUser.enable = true");
		query.orderBy("commonUser.name");
		return entityDao.search(query);
	}

	/**
	 * 获取总金额
	 */
	private float getTotalMoney() {
		String hql = "select (select sum(c.amount) from com.sad.model.CommonUserConsume c where c.businessType.id=1), "
		        + "(select sum(c.amount) from com.sad.model.CommonUserConsume c where c.businessType.id=2) from com.sad.model.baseCode.BaseCoder";
		Object[] object = (Object[]) entityDao.searchHQLQuery(hql).get(0);

		float income = 0, payment = 0;
		if (object[0] != null) {
			income = Float.valueOf(object[0].toString());
		}
		if (object[1] != null) {
			payment = Float.valueOf(object[1].toString());
		}
		return income - payment;
	}

	private float getTotalMoneyByUser(Long commonUserId) {
		String hql = "select (select sum(c.amount) from com.sad.model.CommonUserConsume c where c.businessType.id=1 and c.commonUser.id =:commonUserId), "
		        + "(select sum(c.amount) from com.sad.model.CommonUserConsume c where c.businessType.id=2 and c.commonUser.id =:commonUserId) from com.sad.model.baseCode.BaseCoder";
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("commonUserId", commonUserId);
		Object[] object = (Object[]) entityDao.searchHQLQuery(hql, params).get(0);

		float income = 0, payment = 0;
		if (object[0] != null) {
			income = Float.valueOf(object[0].toString());
		}
		if (object[1] != null) {
			payment = Float.valueOf(object[1].toString());
		}
		return income - payment;
	}

	public String refreshStat() {
		Long commonUserId = getLong("commonUserId");
		put("totalByUser", getTotalMoneyByUser(commonUserId));
		put("total", getTotalMoney());
		return forward("json_refreshStat");
	}

	/**
	 * 余额同步
	 */
	public String moneySync() {
		Float factMoney = getFloat("factMoney");
		String userRange = StringUtils.isNotBlank(get("userRange")) ? get("userRange") : "enabledUser";
		if (factMoney == null) {
			// TODO
			return null;
		}

		float totalMount = getTotalMoney();
		if (factMoney != totalMount) {
			BusinessType businessType = entityDao.get(BusinessType.class,
			        factMoney <= totalMount ? BusinessType.outlay : BusinessType.income);

			OqlBuilder<CommonUser> query = OqlBuilder.from(CommonUser.class, "commonUser");
			if (userRange.equals("enabledUser")) query.where("commonUser.enable = true");
			List<CommonUser> commonUsers = entityDao.search(query);

			if (CollectionUtils.isNotEmpty(commonUsers)) {
				float avgMount;
				if (businessType.getId().equals(BusinessType.outlay)) {
					avgMount = Float.valueOf(String.format("%.1f", (totalMount - factMoney)
					        / commonUsers.size()));
				} else {
					avgMount = Float.valueOf(String.format("%.1f", (factMoney - totalMount)
					        / commonUsers.size()));
				}
				String remark = "余额同步,本次同步用户数:" + commonUsers.size() + ",余额偏差:" + (totalMount - factMoney);

				List<CommonUserConsume> consumes = CollectUtils.newArrayList();
				for (CommonUser commonUser : commonUsers) {
					CommonUserConsume consume = new CommonUserConsume();
					consume.setAmount(avgMount);
					consume.setBusinessType(businessType);
					consume.setCommonUser(commonUser);
					consume.setCreateOn(new java.sql.Date(System.currentTimeMillis()));
					consume.setRemark(remark);
					consumes.add(consume);
				}
				entityDao.saveOrUpdate(consumes);
			}
		}
		return redirect("index", "同步成功");
	}

}
