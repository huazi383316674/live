[#ftl]
[@b.navmenu title="权限管理"]
	[@b.navitem title="控制台" href="index"/]
	[@ems.guard res="/security/user"][@b.navitem title="用户" href="/security/user" /][/@]
	[@ems.guard res="/security/group"][@b.navitem title="用户组" href="/security/group" /][/@]
	[@ems.guard res="/security/menu"][@b.navitem title="菜单" href="/security/menu" /][/@]
	[@ems.guard res="/security/resource"][@b.navitem title="资源" href="/security/resource!search?orderBy=resource.name%20asc" /][/@]
	[#--[@ems.guard res="/security/restrict-meta"][@b.navitem title="数据权限" href="/security/restrict-meta" /][/@]--]
	[@b.navitem title="我的账户" href="/security/my?nav=true" /]
[/@]