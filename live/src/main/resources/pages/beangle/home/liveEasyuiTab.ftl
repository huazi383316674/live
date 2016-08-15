[#ftl]

<script type="text/javascript">
	jQuery('#main_tabDiv').tabs({ 
	　　width: jQuery("#main_tabDiv").parent().width()-10, 
	　　height: "auto"
	});
	
	// 页面跳转方法
	function goto(title, href) {
		var href_ = href;
		var firstWord = href.substr(0, 1);
		if (firstWord == "/") href_ = href.substr(1);
		
		var selectedTab = jQuery('#main_tabDiv').tabs('getSelected');	// 获取当前选中的tab
		
		// 判断选中的菜单是否已经有了对应的tab，如果有了该tab但当前不是显示的该tab，则切换到该tab即可，如果显示的是该tab则刷新页面
		if (jQuery("#main_tabDiv").tabs("exists", title)) {
			jQuery("#main_tabDiv").tabs("select", title);
			
			if (selectedTab.panel('options').title == title) {
				jQuery('#main_tabDiv').tabs('update', {
		            tab: selectedTab,
		            options:{
		                content: "<iframe frameborder=0 src="+ href_ +" height=600px width=100% scrolling='auto' /></iframe>"
		            }
				});
			}
		} else {
			jQuery('#main_tabDiv').tabs('add',{
	 			title: title, closable: true, content: "<iframe frameborder=0 src="+ href_ +" height=600px width=100% scrolling='auto' /></iframe>",
			});
		}
	}
</script>