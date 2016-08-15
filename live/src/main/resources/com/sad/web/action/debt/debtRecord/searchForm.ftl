[#ftl/]

[#assign debtTypes = {'borrowIn':'借入', 'borrowOut':'借出'} /]

[@b.textfield name="debtRecord.name" label="债务名称" /]
[@b.textfield name="debtRecord.debtUserName" label="债务人" /]
[@b.textfield name="debtRecord.sum" label="金额" /]
[@b.select name="debtType" items=debtTypes! label="债务类型" empty="..." /]
[@b.select name="debtRecord.finished" items={'0':'否', '1':'是'} label="是否已归还" /]
[@b.field label="债务产生年月"]<input type="text" name="createYearManth" onfocus="WdatePicker({dateFmt:'yyyy-MM'})" />[/@]
[@b.field label="债务归还年月"]<input type="text" name="returnYearMonth" onfocus="WdatePicker({dateFmt:'yyyy-MM'})" />[/@]
[@b.textfield name="debtRecord.remark" label="备注" /]
