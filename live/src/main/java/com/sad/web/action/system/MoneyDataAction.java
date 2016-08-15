package com.sad.web.action.system;

import org.beangle.ems.config.model.PropertyConfigItemBean;
import org.beangle.ems.web.action.SecurityActionSupport;
import org.beangle.model.query.builder.OqlBuilder;

import com.sad.service.system.MoneyDataService;
import com.sad.service.system.impl.MoneyBackupMessage;
import com.sad.util.MoneyConstants;

/**
 * 数据备份
 */
public class MoneyDataAction extends SecurityActionSupport {

	private MoneyDataService moneyDataService;

	public String index() {
		String[] configParams = new String[] { MoneyConstants.batPath, MoneyConstants.dmpPath,
		        MoneyConstants.expCommand, MoneyConstants.zipPath, MoneyConstants.backupMailAdd,
		        MoneyConstants.backupMailHost, MoneyConstants.backupMailPwd };
		put("configParams", configParams);

		OqlBuilder<PropertyConfigItemBean> query = OqlBuilder.from(PropertyConfigItemBean.class, "config");
		query.where("config.name in(:configNames)", configParams);
		put("configItems", entityDao.search(query));
		return forward();
	}

	public String backup() {
		MoneyBackupMessage message = new MoneyBackupMessage();
		moneyDataService.backupDatas(message);
		put("backupMassage", message);
		return forward();
	}

	public void setMoneyDataService(MoneyDataService moneyDataService) {
		this.moneyDataService = moneyDataService;
	}
}
