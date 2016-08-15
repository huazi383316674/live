[#ftl]
[@b.head/]
[#include "../nav.ftl"/]
[#include "scope.ftl"/]
[@b.toolbar title="新建/修改资源"]bar.addBack();[/@]

<div style="width:850px">
[@b.form action="!save" theme="list"]
	[@b.textfield name="resource.name" required="true" label="common.name" value="${resource.name!}" maxlength="50" comment="资源名称唯一"/]
	[@b.radios label="能否独立访问" name="resource.needParams" value=resource.needParams items="1:需要其它参数,0:访问时不需要额外参数"/]
	[@b.textfield name="resource.title" required="true" label="标题" value="${resource.title!}" maxlength="50"/]
	[@b.textfield name="resource.remark" label="common.remark" value="${resource.remark!}" maxlength="50"/]
	[@b.radios label="可见范围" name="resource.scope" items=scopeTitles value=resource.scope?string/]
	[@b.radios label="common.status" name="resource.enabled" value=resource.enabled items="1:action.activate,0:action.freeze"/]
	[#--[@b.checkboxes label="适用用户" name="categoryId" items=categories value=resource.categories valueName="title"/]--]
	[#--[@b.select2 label="数据限制对象" name1st="RestrictEntities"  name2nd="restrictEntityId" items1st=restrictEntities items2nd=resource.entities/]--]
	[@b.formfoot]
		[@b.reset/]&nbsp;&nbsp;[@b.submit value="action.submit"/]
		[@b.redirectParams/]
		<input type="hidden" name="resource.id" value="${(resource.id)!}" />
		
		[#--适用用户--]
		<input type="hidden" name="categoryId" value="3" />
	[/@]
[/@]
</div>
[@b.foot/]