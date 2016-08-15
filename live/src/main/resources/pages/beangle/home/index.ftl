[#ftl]
[@b.head]
<link href="${base}/static/themes/${b.theme.ui}/home.css" rel="stylesheet" type="text/css" />
<script src="${base}/static/scripts/jscroll.js" type="text/javascript"></script>
<script src="${base}/static/scripts/jquery.cookie.js" type="text/javascript"></script>

<link rel="stylesheet" type="text/css" href="${base}/static/scripts/easyui/themes/bootstrap/easyui.css">
<link rel="stylesheet" type="text/css" href="${base}/static/scripts/easyui/themes/icon.css">
<script type="text/javascript" src="${base}/static/scripts/easyui/jquery.easyui.min.js"></script>

<style>
#_menu_folder {
	height:100%; width:100%; background-color:rgba(0, 0, 0, 0.2); cursor:pointer;
}
#_menu_folder:hover {
	height:100%; width:100%; background-color:rgba(222, 222, 222, 1);
}
.arrow-right {
	width: 0; height: 0; border-top: 6px solid transparent; border-bottom: 6px solid transparent; 
	border-left: 6px solid rgba(0, 0, 0, 0.6); top:50%; position:absolute;
}
.arrow-left {
	width: 0; height: 0; border-top: 6px solid transparent; border-bottom: 6px solid transparent; 
	border-right:6px solid rgba(0, 0, 0, 0.6); top:50%; position:absolute;
}
.color_theme_selector {display:inline-block;width:10px;height:10px;margin-right:2px;}
</style>
[/@]

[#assign color_theme = {'#FFFFFF' : '白色', '#FAF9DE' : '杏仁黄', '#FFF2DE' : '秋叶褐', '#FDE6E0' : '胭脂红', '#E3EDCD' : '青草绿', '#DCE2F1' : '海天蓝', '#E9EBFE' : '葛巾紫', '#EAEAEF' : '极光灰'} /]
				
<div class="banner">
	<div>
		<div class="banner_area">
			<table cellpadding="0" cellspacing="0"  class="button_box_1">
				<tr>
					<td width="25"></td>
					<td width="90">
						<a href="#" class="a3" onclick="editAccount()">我的账户</a>&nbsp;&nbsp;
					</td>
					<td width="90">
						[@b.a href="!welcome" cssClass="a3" target="main"]返回首页[/@]&nbsp;&nbsp;
					</td>
					<td>
						[@b.a href="logout" cssClass="a3" target="_top"]退出[/@]
					</td>
				</tr>
			</table>
		</div>
		
		<div class="banner_area">
			[@b.form]
				[#list color_theme?keys as color]
					<a href="#color_theme_${color}" id="color_theme_selector_${color?replace('#', '')}" class="color_theme_selector" style="background-color:${color};" title='${color_theme[color]}'></a>
				[/#list]
				
				[@b.a href="/security/my" target="_blank" title="查看登录记录"]<font color='white'>${user.fullname}(${user.username})</font>[/@]&nbsp;&nbsp;
			[/@]
		</div>
	</div>
	
	<br><br>
	<div style="float:right;display:block;clear:both;">
		[#macro i18nNameTitle(entity)][#if locale.language?index_of("en")!=-1][#if entity.engTitle?if_exists?trim==""]${entity.title?if_exists}[#else]${entity.engTitle?if_exists}[/#if][#else][#if entity.title?if_exists?trim!=""]${entity.title?if_exists}[#else]${entity.engTitle?if_exists}[/#if][/#if][/#macro]
		<ul class="nav_box" id="nav_box">
		[#list menus?if_exists as module]
			<li [#if module_index==0]class="current"[/#if]>[@b.a href="!submenus?menu.id=${module.id}" target="menu_panel" ]<span>[@i18nNameTitle module/]</span>[/@]</li>
		[/#list]
		</ul>
	</div>
</div>

<script>
	jQuery('.nav_box li').each(function(index, li) {
		jQuery(this).focus(function(e) {
			jQuery(this).blur();
		});
		jQuery(this).click(function(e) {
			jQuery('li', jQuery(this).parent()).each(function(index, li) {
				jQuery(this).removeClass('current');
			});
			jQuery(this).addClass('current');
		});
	});

	jQuery(function() {
	[#list color_theme?keys as color]
		jQuery('#color_theme_selector_${color?replace('#', '')}').click(function() {
			jQuery(document.body).css('background-color', '${color}');
			jQuery.cookie('_body_color_theme', '${color}', { expires: 30, path: '/' });
		});
	[/#list]
		if(jQuery.cookie('_body_color_theme')) {
			var color = jQuery.cookie('_body_color_theme')
			jQuery(document.body).css('background-color', color);
		}
	});
</script>

<table id="mainTable" style="width:100%;height:95%;clear:both;float:left;">
	<tr>
		<td style="height:100%;width:10%" id="leftTD" valign="top">
			[@b.div id="menu_panel" href="!submenus?menu.id=${(menus?first.id)!}" /]
	   	</td>
	   	<td style="height:100%;width:8px">
	   		<!-- 折叠菜单栏的bar -->
			<div id="_menu_folder"><div id="_menu_folder_tri"></div></div>
	   	</td>
		<td id="rightTD" valign="top">
	   		[#--[@b.div id="main" href="!welcome" /]--]
	   		
	   		<div class="easyui-tabs" id="main_tabDiv" >
				[@b.div id="main" title="welcome" href="!welcome" style="padding:10px;"/]
			</div>
	   	</td>
	</tr>
</table>

[#include "liveEasyuiTab.ftl" /]

<script type="text/javascript">
	function editAccount(){
		var url = "${b.url('/security/my!edit')}";
		var selector= window.open(url, 'selector', 'scrollbars=yes,status=yes,width=1,height=1,left=1000,top=1000');
		selector.moveTo(200,200);
		selector.resizeTo(350,250);
	}
	jQuery(function() {
		jQuery('#_menu_folder_tri').addClass('arrow-left');
		jQuery('#_menu_folder').click(function() {
			jQuery('#leftTD').toggle(200);
			var jq_tri = jQuery('#_menu_folder_tri');
			if(jq_tri.hasClass('arrow-left')) {
				jq_tri.removeClass('arrow-left');
				jq_tri.addClass('arrow-right');
			} else {
				jq_tri.removeClass('arrow-right');
				jq_tri.addClass('arrow-left');
			}
		});
	});
</script>
[@b.foot/]