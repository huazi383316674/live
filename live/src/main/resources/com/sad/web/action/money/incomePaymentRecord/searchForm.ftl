[#ftl/]
[@b.textfield name="record.name" label="名称" /]
[@b.textfield name="record.amount" label="金额" /]
[@b.field label="月份"]<input type="text" name="createMonth" onfocus="WdatePicker({dateFmt:'yyyy-MM'})" />[/@]
[@b.field label="日期"]<input type="text" name="record.createOn" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd'})" />[/@]
[@b.textfield name="record.remark" label="备注" /]
[@b.select name="record.type.businessType.id" id="record.businessTypeId" items=businessTypes?sort_by("code")! label="业务类型" empty="..." /]
[@b.select name="record.type.id" id="record.recordTypeId" label="收支类型" empty="..." required="true" /]