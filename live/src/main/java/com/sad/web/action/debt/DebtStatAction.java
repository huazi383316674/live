package com.sad.web.action.debt;

import java.util.HashMap;
import java.util.Map;

import org.beangle.ems.web.action.SecurityActionSupport;

public class DebtStatAction extends SecurityActionSupport {

	public String stat() {
		StringBuilder hqlQuery = new StringBuilder();
		hqlQuery
		        .append("select r.debtUserName, r.debtType, ")
		        .append(
		                "(select sum(r1.amount) from com.sad.model.DebtRecord r1 where r1.debtUserName=r.debtUserName and r1.user.id = r.user.id and r1.debtType = r.debtType), ")
		        .append(
		                "(select sum(re.amount) from com.sad.model.DebtReturnRecord re where re.debtRecord.id in ")
		        .append(
		                "(select r2.id from com.sad.model.DebtRecord r2 where r2.user.id = r.user.id and r2.debtUserName=r.debtUserName and r2.debtType = r.debtType)) ")
		        .append(
		                "from com.sad.model.DebtRecord r where r.user.id =:userId group by r.user.id, r.debtUserName, r.debtType order by r.debtUserName");
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("userId", getUserId());
		put("debts", entityDao.searchHQLQuery(hqlQuery.toString(), params));
		return forward();
	}
}
