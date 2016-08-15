[#ftl/]
[@b.textfield name="suggest.no" label="编号" /]
[@b.textfield name="suggest.speaker.fullname" label="提出人" /]
[@b.textfield name="suggest.speaker.department.name" label="所属科室" /]
[@b.field label="一级模块"]<select name="suggest.firstModule">
		<option value="">...</option>
		[#list firstModules! as firstModule]<option value="${firstModule}">${firstModule}</option>[/#list]
	</select>
[/@]
[@b.textfield name="suggest.secondModule" label="二级模块" /]
[@b.field label="提出日期从"]<input id="csa_" type="text" value="" name="createdStartAt" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'cea_\')}'})" title="提出日期">[/@]
[@b.field label="到"]<input id="cea_" type="text" value="" name="createdEndAt" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'csa_\')}'})" title="提出日期">[/@]
[@b.field label="更新日期从"]<input id="usa_" type="text" value="" name="updatedStartAt" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',maxDate:'#F{$dp.$D(\'uea_\')}'})" title="提出日期">[/@]
[@b.field label="到"]<input id="uea_" type="text" value="" name="updatedEndAt" onfocus="WdatePicker({dateFmt:'yyyy-MM-dd',minDate:'#F{$dp.$D(\'usa_\')}'})" title="提出日期">[/@]
[@b.select label="处理状态" name="suggest.handleType.id" empty="..." items=handleTypes! /]
[@b.textfield name="suggest.appointUser.fullname" label="指派给" /]
[@b.select label="是否通过" name="suggest.passed" empty="..." items={"1" : "是", "0" : "否"} /]
[@b.textfield name="suggest.content" label="问题描述" /]
[@b.textfield name="suggest.remark" label="备注" /]