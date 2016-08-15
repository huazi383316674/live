[#ftl]
{
	datas : [[#list users! as user]{id:"${user.id}", name:"${user.name!}", fullname:"${user.fullname!}", departName:"${(user.department.name)!}"}[#if user_has_next],[/#if][/#list]]
}