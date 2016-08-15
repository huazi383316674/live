package com.sad.dao;

import java.util.List;

import com.sad.model.DebtRecord;
import com.sad.model.DebtReturnRecord;
import com.sad.model.IncomePaymentRecord;

public interface DebtDao {

	/**
	 * 保存债务清单及收支清单
	 * 
	 * @param debtRecord
	 * @param record
	 */
	public void saveDebtAndInPayRecord(DebtRecord debtRecord, IncomePaymentRecord record);

	/**
	 * 保存债务归还清单
	 * (包括新增收支清单及更新债务清单)
	 * 
	 * @param returnRecord
	 * @param record
	 */
	public void saveDebtReturn(DebtReturnRecord returnRecord, DebtRecord debtRecord,
	        IncomePaymentRecord record);

	/**
	 * 删除债务归还清单
	 * (包括移除对应的收支清单及更新债务清单)
	 * 
	 * @param returnRecords
	 * @param debtRecord
	 */
	public void removeDebtReturn(List<DebtReturnRecord> returnRecords, DebtRecord debtRecord);
}
