[#ftl]
[@b.head/]
[@b.toolbar title="添加/修改收支清单"]
	bar.addBack();
[/@]

[@b.form name="recordEditForm" action="!save" title="" theme="list"]
	[@b.textfield name="record.name" label="名称" value="${(record.name)!}" maxlength="200" required="true" style="width:220px" /]
	[@b.textfield name="record.amount" label="金额" value="${(record.amount)!}" maxlength="8" required="true" style="width:80px" /]
	[@b.select name="businessType.id" id="businessTypeId" items=businessTypes?sort_by("code")! label="业务类型" empty="..." value=(record.type.businessType.id)! required="true" style="width:225px" /]
	[@b.select name="record.type.id" id="recordTypeId" label="收支类型" empty="..." required="true" style="width:225px" /]
	[@b.datepicker label="日期" required="true" name="record.createOn" value="${(record.createOn?string('yyyy-MM-dd'))!}" style="width:225px"  format="yyyy-MM-dd" /]
	[@b.textarea cols="33" rows="2" label="备注" name="record.remark" maxlength="200" value="${(record.remark)!}" style="font-size:12px" /]
	[@b.formfoot]
		[@b.redirectParams /]
		[@b.submit value="${b.text('action.save')}"/]		
		<input type="reset" value="${b.text("action.reset")}" />
		<input type="hidden" name="record.id" value="${(record.id)!}" />
	[/@]
[/@]

<script>
	jQuery(function(){
		jQuery("#businessTypeId").change(function() {
			var selectId = "recordTypeId";
			var url = "incomePaymentRecord!getIncomePaymentTypes.action?businessTypeId=" + jQuery("#businessTypeId").val() + "&_="+ new Date().getTime();
			
			jQuery("#" + selectId).find("option").remove();
			jQuery("#" + selectId).append("<option value=''>...</option>");	
			
			jQuery.get(url, function(data) {
				var dataObj = eval("("+data+")");
				jQuery.each(dataObj.datas, function(idx,item) {
					if ('${(record.type.id)!}' == item.id) { 
						jQuery("#" + selectId).append("<option value="+item.id+" selected=selected>"+item.name+"</option>");
					} else { jQuery("#" + selectId).append("<option value="+item.id+">"+item.name+"</option>"); }	
				})
			})
		})
		
		jQuery("#businessTypeId").change();
	})
</script>
[@b.foot/]