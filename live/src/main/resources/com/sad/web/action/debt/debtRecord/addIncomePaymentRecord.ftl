[#ftl]
[@b.head/]
[#if record.id??][#assign title='更新收支清单' /][#else][#assign title='添加收支清单' /][/#if]
[@b.toolbar title="${title}"]
	bar.addBack();
[/@]

[@b.form name="recordEditForm" action="!save" title="" theme="list" target="contentDiv"]
	[@b.textfield name="record.name" label="名称" value="${(record.name)!}" maxlength="200" required="true" style="width:220px" /]
	[@b.textfield name="record.amount" label="金额" value="${(record.amount)!}" maxlength="8" required="true" style="width:80px" /]
	[@b.select name="businessType.id" id="businessTypeId" items=businessTypes! label="业务类型" empty="..." value=(record.type.businessType.id)! required="true" style="width:225px" disabled="true"  /]
	[@b.select name="record.type.id" id="recordTypeId" label="收支类型" empty="..." required="true" style="width:225px" /]
	[@b.datepicker label="时间" required="true" name="record.createOn" value="${(record.createOn?string('yyyy-MM-dd'))!}" style="width:225px" format="yyyy-MM-dd" /]
	[@b.textarea cols="33" rows="2" label="备注" name="record.remark" maxlength="200" value="${(record.remark)!}" style="font-size:12px" /]
	[@b.formfoot]
		[@b.redirectParams /]
		<input type="button" value="${b.text("action.save")}" onclick="saveAll();" />
		<input type="reset" value="${b.text("action.reset")}" />
		<input type="hidden" name="record.id" value="${(record.id)!}" />
	[/@]
[/@]

<script>
	jQuery(function(){
		jQuery.colorbox({transition:'none', title:"同步收支清单", overlayClose:false, width:"650px", height:"450px", inline:true, href:"#incomePaymentDiv"});
	
		jQuery("#businessTypeId").change(function() {
			var selectId = "recordTypeId";
			var url = "incomePaymentRecord!getIncomePaymentTypes.action?businessTypeId=" + jQuery("#businessTypeId").val();
			
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
	
	
	function saveAll() {
		var res = null;
		bg.ui.load('validity');
  		jQuery.validity.start();
		jQuery(":input[name=record\\.name]", document.recordEditForm).require();
		jQuery(":input[name=record\\.sum]", document.recordEditForm).require();
		jQuery(":input[name=businessType\\.id]", document.recordEditForm).require();
		jQuery(":input[name=record\\.type\\.id]", document.recordEditForm).require();
		jQuery(":input[name=record\\.createOn]", document.recordEditForm).require();
		res = jQuery.validity.end().valid;
		if(false == res) return;
	
		bg.form.transferParams(document.debtRecordEditForm, document.recordEditForm, null, false);
		bg.form.submit(document.recordEditForm, "debtRecord!save.action");
		jQuery.colorbox.close();
	}
</script>
[@b.foot/]