package com.sad.web.action.baseCode;

import java.lang.reflect.Field;
import java.lang.reflect.Modifier;
import java.util.Date;
import java.util.List;

import org.apache.commons.lang.StringUtils;
import org.beangle.commons.collection.Order;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.model.baseCode.BaseCode;
import com.sad.model.baseCode.BaseCoder;
import com.sad.model.baseCode.BusinessType;
import com.sad.web.action.MoneyCommonAction;

public class MoneyBaseCodeAction extends MoneyCommonAction {

	public static final String EXT = "ext/";

	public String index() {
		put("baseCoders", entityDao.search(OqlBuilder.from(BaseCoder.class).orderBy("id")));
		put("ti", new Date().getTime());
		return forward();
	}

	public String search() {
		Long coderId = getLong("coderId");
		if (coderId == null) {
			// TODO
		}

		BaseCoder coder = entityDao.get(BaseCoder.class, coderId);

		OqlBuilder<? extends BaseCode> query = OqlBuilder.from(getClass(coder.getClassName()), "model");
		populateConditions(query);
		if (StringUtils.isBlank(get(Order.ORDER_STR))) {
			query.orderBy("model.code");
		} else {
			query.orderBy(get(Order.ORDER_STR));
		}
		query.limit(getPageLimit());
		List<? extends BaseCode> models = entityDao.search(query);

		put("models", models);
		put("coder", coder);

		if (hasExtPros(coder.getClassName())) { return forward(EXT + getCommandName(coder.getClassName())
		        + "List"); }
		return forward();
	}

	public String edit() {
		BaseCoder coder = entityDao.get(BaseCoder.class, getLong("coderId"));

		if (getLong("modelId") != null) {
			put("model", entityDao.get(coder.getClassName(), getLong("modelId")));
		}
		put("coder", coder);

		if (hasExtPros(coder.getClassName())) {
			addBaseCode("businessTypes", BusinessType.class);
			return forward(EXT + getCommandName(coder.getClassName()) + "Form");
		}
		return forward();
	}

	public String save() {
		BaseCoder coder = entityDao.get(BaseCoder.class, getLong("coderId"));

		entityDao.saveOrUpdate(populateEntity(getClass(coder.getClassName()), "model"));
		return redirect("search", "操作成功");
	}

	public String remove() {
		BaseCoder coder = entityDao.get(BaseCoder.class, getLong("coderId"));

		try {
			entityDao.remove(populateEntity(getClass(coder.getClassName()), "model"));
		} catch (Exception e) {
			return redirect("search", "删除失败，已有收支记录引用该类别");
		}
		return redirect("search", "删除成功");
	}

	@SuppressWarnings("unchecked")
	public Class<? extends BaseCode> getClass(String name) {
		try {
			return (Class<? extends BaseCode>) Class.forName(name);
		} catch (Exception e) {
			throw new RuntimeException("not found class:" + name);
		}
	}

	private boolean hasExtPros(String className) {
		Field[] fields = getClass(className).getDeclaredFields();
		for (int i = 0; i < fields.length; i++) {
			if (!(Modifier.isFinal(fields[i].getModifiers()) || Modifier.isStatic(fields[i].getModifiers()))) { return true; }
		}
		return false;
	}

	private static String getCommandName(String entityName) {
		return StringUtils.uncapitalize(StringUtils.substringAfterLast(entityName, "."));
	}
}
