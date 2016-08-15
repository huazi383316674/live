[#ftl]

[#function getBusinessType id]
	[#if id?string = '1'][#return '收入' /][#else][#return '支出' /][/#if]
[/#function]

{
datas : [[#list records! as record]{name : '${record.name}', amount : '${record.amount}', type : '${record.type.name}', businessType : '${getBusinessType(record.type.businessType.id)}'}[#if record_has_next],[/#if][/#list]]
}

