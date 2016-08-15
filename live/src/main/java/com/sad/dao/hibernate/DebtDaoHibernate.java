package com.sad.dao.hibernate;

import java.util.List;

import org.beangle.ems.security.SecurityUtils;
import org.beangle.ems.security.User;
import org.beangle.model.persist.hibernate.BaseDaoHibernate;

import com.sad.dao.DebtDao;
import com.sad.model.DebtRecord;
import com.sad.model.DebtReturnRecord;
import com.sad.model.IncomePaymentRecord;

public class DebtDaoHibernate extends BaseDaoHibernate implements DebtDao {

	/**
	 * 保存债务清单及收支清单
	 */
	public void saveDebtAndInPayRecord(DebtRecord debtRecord, IncomePaymentRecord record) {
		record.setUser(entityDao.get(User.class, SecurityUtils.getUserId()));
		entityDao.saveOrUpdate(record);

		debtRecord.setInPayRecord(record);
		entityDao.saveOrUpdate(debtRecord);
	}

	/**
	 * 保存债务归还清单
	 * (包括新增收支清单及更新债务清单)
	 */
	public void saveDebtReturn(DebtReturnRecord returnRecord, DebtRecord debtRecord,
	        IncomePaymentRecord record) {
		record.setUser(entityDao.get(User.class, SecurityUtils.getUserId()));
		entityDao.saveOrUpdate(record);

		returnRecord.setInPayRecord(record);
		debtRecord.getReturnRecords().add(returnRecord);

		// 如果债务归还完毕,则更新债务单
		if (checkDebtRetunFinish(debtRecord)) {
			debtRecord.setFinished(true);
			debtRecord.setReturnOn(returnRecord.getReturnOn());
		}
		entityDao.saveOrUpdate(debtRecord);
	}

	/**
	 * 删除债务归还清单
	 * (包括移除对应的收支清单及更新债务清单)
	 */
	public void removeDebtReturn(List<DebtReturnRecord> returnRecords, DebtRecord debtRecord) {
		debtRecord.getReturnRecords().removeAll(returnRecords);
		if (!checkDebtRetunFinish(debtRecord)) {
			debtRecord.setFinished(false);
			debtRecord.setReturnOn(null);
		}
		entityDao.saveOrUpdate(debtRecord);
	}

	private boolean checkDebtRetunFinish(DebtRecord debtRecord) {
		float returnSum = 0;
		for (DebtReturnRecord returnRecord : debtRecord.getReturnRecords()) {
			returnSum += returnRecord.getAmount();
		}
		if (returnSum >= debtRecord.getAmount()) { return true; }
		return false;
	}
}
