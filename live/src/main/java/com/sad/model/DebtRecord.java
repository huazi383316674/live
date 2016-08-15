package com.sad.model;

import java.sql.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.validation.constraints.NotNull;

import org.beangle.commons.collection.CollectUtils;
import org.beangle.ems.security.User;
import org.beangle.model.pojo.LongIdObject;

@Entity
public class DebtRecord extends LongIdObject {

	private static final long serialVersionUID = 1L;

	/** 债务名称 */
	private String name;

	/** 金额 */
	private float amount;

	/** 债务类别 */
	@NotNull
	@Enumerated(EnumType.STRING)
	private DebtType debtType;

	/** 债务人 */
	@NotNull
	private String debtUserName;

	@NotNull
	private User user;

	private String remark;

	/** 债务产生日期 */
	@NotNull
	private Date createOn;

	/** 债务预归还日期 */
	private Date preReturnOn;

	/** 债务归还日期 */
	private Date returnOn;

	/** 是否已归还完 */
	private boolean finished;

	/** 收支记录 */
	@OneToOne(optional = true, cascade = { CascadeType.ALL }, orphanRemoval = true)
	private IncomePaymentRecord inPayRecord;

	/** 归还记录 */
	@OneToMany(mappedBy = "debtRecord", orphanRemoval = true, targetEntity = DebtReturnRecord.class, cascade = { CascadeType.ALL })
	private List<DebtReturnRecord> returnRecords = CollectUtils.newArrayList();

	public static enum DebtType {
		borrowIn("借入"), borrowOut("借出");

		private String fullName;

		private DebtType() {
		}

		private DebtType(String fullName) {
			this.fullName = fullName;
		}

		public String getEngName() {
			return this.name();
		}

		public String getFullName() {
			return this.fullName;
		}

		public static DebtType getDebtType(String typeName) {
			for (DebtType debtType : DebtType.values()) {
				if (debtType.name().equals(typeName)) return debtType;
			}
			return null;
		}
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public float getAmount() {
		return amount;
	}

	public void setAmount(float amount) {
		this.amount = amount;
	}

	public DebtType getDebtType() {
		return debtType;
	}

	public void setDebtType(DebtType debtType) {
		this.debtType = debtType;
	}

	public String getDebtUserName() {
		return debtUserName;
	}

	public void setDebtUserName(String debtUserName) {
		this.debtUserName = debtUserName;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Date getCreateOn() {
		return createOn;
	}

	public void setCreateOn(Date createOn) {
		this.createOn = createOn;
	}

	public Date getPreReturnOn() {
		return preReturnOn;
	}

	public void setPreReturnOn(Date preReturnOn) {
		this.preReturnOn = preReturnOn;
	}

	public Date getReturnOn() {
		return returnOn;
	}

	public void setReturnOn(Date returnOn) {
		this.returnOn = returnOn;
	}

	public boolean isFinished() {
		return finished;
	}

	public void setFinished(boolean finished) {
		this.finished = finished;
	}

	public IncomePaymentRecord getInPayRecord() {
		return inPayRecord;
	}

	public void setInPayRecord(IncomePaymentRecord inPayRecord) {
		this.inPayRecord = inPayRecord;
	}

	public List<DebtReturnRecord> getReturnRecords() {
		return returnRecords;
	}

	public void setReturnRecords(List<DebtReturnRecord> returnRecords) {
		this.returnRecords = returnRecords;
	}

}
