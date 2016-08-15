[#ftl]
[@b.head/]
<style>
	.loginButton {
		width: auto; padding: 9px 15px; background: #617798; border: 0; font-size: 14px; 
		color: #FFFFFF; -moz-border-radius: 5px; -webkit-border-radius: 5px; cursor: pointer
	}
	
	input {
		padding: 9px;
		border: solid 1px #E5E5E5;
		outline: 0;
		width: 160px;
		background: -webkit-gradient(linear, left top, left 25, from(#FFFFFF), color-stop(4%, #EEEEEE), to(#FFFFFF));
		background: -moz-linear-gradient(top, #FFFFFF, #EEEEEE 1px, #FFFFFF 25px);
		box-shadow: rgba(0,0,0, 0.1) 0px 0px 8px;
		-moz-box-shadow: rgba(0,0,0, 0.1) 0px 0px 8px;
		-webkit-box-shadow: rgba(0,0,0, 0.1) 0px 0px 8px;
		font-family: Verdana, Tahoma, sans-serif;
		font-size: 13px;
		font-style: normal;
		line-height: 100%;
		font-weight: normal;
		font-variant: normal;
		color: #617798;
	}
</style>
[#if ((Session['loginFailureCount'])?default(0)>1)][#assign needCaptcha=true][#else][#assign needCaptcha=false][/#if]

<div id="loginDiv" style="display:none; width:200px">
[@b.form name="loginForm" action="login" target="_top"]
<table width="100%">
	<tr>
		<td height="30px"><B>综合生活管理系统&nbsp;v2.0</B></td>
	</tr>
	<tr>
		<td>[@b.messages/]</td>
	</tr>
	<tr>
		<td height="30px"><input name="username" id="username" title="请输入用户名" type="text" value="用户名" tabindex="1"/></td>
	</tr>
	<tr>
		<td height="30px"><input name="password" id="password" title="请输入密码" type="password" value="密码" tabindex="2"/></td>
	</tr>
	
	[#if needCaptcha]
	<tr>
		<td height="30px">
			<input id="captcha" name="captcha" tabindex="3" type="text" style="width:70px;"/>
			<img src="${b.url('security/captcha')}" title="验证码,点击更换一张" onclick="changeCaptcha(this)" alt="验证码" width="60" height="35" style="vertical-align:top;"/>
		</td>
	</tr>
	[/#if]
	
	<tr>
		<td height="30px">
			[@b.submit name="submitBtn" class="loginButton" value="登录" onsubmit="checkLogin" tabindex="5"][/@]
		</td>
	</tr>
</table>
[/@]
</div>
<script type="text/javascript">
	art.dialog({
	    content: document.getElementById('loginDiv'), id:'loginDialog', title:"登陆", left:'90%', top:'50%'
	});
	
	art.dialog({
	    content: "<img src='${base}/static/images/11111.jpg' title='sad'/>",
	    id: 'EF1893L1',
	    title:"hello?",
	    width:600,
	    height:500,
	    width:400, height:350, left:300, top:30,
	    zIndex:2
	});
	
	art.dialog({
	    content: "<div id='test2'><img src='${base}/static/images/22222.jpg' width='100%' height='100%' /><div>",
	    id: 'EF1893L11',
	    title:"hi?",
	    width:350, height:300, left:'0%', top:'0%',
	    zIndex:1
	});
	
	jQuery(function() {
		jQuery("#username").focus(function () { if (jQuery(this).val() === "用户名") jQuery(this).val("");
		}).blur(function() { if (jQuery(this).val() === "") jQuery(this).val("用户名"); });
		
		jQuery("#password").focus(function () { if (jQuery(this).val() === "密码") jQuery(this).val("");
		}).blur(function() { if (jQuery(this).val() === "") jQuery(this).val("密码"); });
	})
						
	function checkLogin(){
		//var X = $('#test2').offset().left;
		//var Y = $('#test2').offset().top;
		//alert(X + "-" + Y); return false; 
	
		var form = document.loginForm;
		
		if(!form['username'].value || form['username'].value ==="用户名") {
			art.dialog({ lock: true, opacity: 0.7, content: '请填写用户名!', icon: 'error', noFn: true, noText: '确定', closeFn: function() { form['username'].focus(); } }); 
			return false;
		}
		if(!form['password'].value || form['password'].value ==="密码") {
			art.dialog({ lock: true, opacity: 0.7, content: '请填写密码!', icon: 'error', noFn: true, noText: '确定', closeFn: function() { form['password'].focus(); } }); 
			return false;
		}
		[#if needCaptcha]
		if(!form['captcha'].value) {
			art.dialog({ lock: true, opacity: 0.7, content: '请填写验证码!', icon: 'error', noFn: true, noText: '确定', closeFn: function() { form['captcha'].focus(); } }); 
			return false;
		}
		[/#if]
		return true;
	}
	
	function changeCaptcha(obj) {
		//每次请求需要一个不同的参数，否则可能会返回同样的验证码
		//这和浏览器的缓存机制有关系，也可以把页面设置为不缓存，这样就不用这个参数了。
		obj.src="${b.url('security/captcha')}?t="+new Date().getTime();
	}
</script>


 