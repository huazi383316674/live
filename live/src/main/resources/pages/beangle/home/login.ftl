[#ftl]
[@b.head/]
<script src="${base}/static/css_browser_selector.js" type="text/javascript"></script>

<style>
html, body {
	width : 100%; height : 100%
}
body {
	background-color :  #0F6CB1;
	background-image :  -moz-radial-gradient(center, ellipse closest-corner, #29C4FD 20%, #0F6CB1 100%);
	background-image :  -webkit-radial-gradient(center, ellipse closest-side, #29C4FD 30%, #0F6CB1 100%);
	background-image :  -ms-radial-gradient(center, ellipse closest-side, #29C4FD 20%, #0F6CB1 100%);
	background-image :  -o-radial-gradient(center, ellipse closest-side, #29C4FD 20%, #0F6CB1 100%);
}
.logindiv {
	z-index : 1;
	width : 700px;
	height : 360px;
	display : block;
	position : absolute;
	left : 50%;
	top : 50%;	
	margin-left : -350px;
	margin-top : -180px;
	border : 1px #106EB6 solid;
	text-align : center;
	background-color : #FFFFFF;
  	background-image: -webkit-gradient(linear, top, bottom, from(#D1E3ED), to(#FFFFFF));
  	background-image: -webkit-linear-gradient(top, #D1E3ED 0%, #FFFFFF 20%);
  	background-image:    -moz-linear-gradient(top, #D1E3ED 0%, #FFFFFF 20%);   
  	background-image:     -ms-linear-gradient(top, #D1E3ED 0%, #FFFFFF 20%);   
  	background-image:      -o-linear-gradient(top, #D1E3ED 0%, #FFFFFF 20%);   
  	background-image:         linear-gradient(to bottom, #D1E3ED 0%, #FFFFFF 20%);
}
.logindiv h1 {
	color : #074B7C;
	font-weight : bold;
	font-size : 20pt;
	margin-top : 5%;
}
.logindiv .logintable {
	position : absolute;
	width : 216px;
	height : 104px;
	right : 3px;
	top : 50%;
	margin-top : -82px;
	border : 1px #B0C5E0 solid;
	-webkit-border-radius : 3px;
	   -moz-border-radius : 3px;
	    -ms-border-radius : 3px;
	     -o-border-radius : 3px;
}
.foot {
	z-index : 0;
	display : block;
	position : absolute;
	width : 100%;
	height : 30%;
	bottom : 0px;
	background-image: -webkit-gradient(linear, top, bottom, from(#054E81), to(#0D5D9A));
  	background-image: -webkit-linear-gradient(top, #054E81 0%, #0D5D9A 20%);
  	background-image:    -moz-linear-gradient(top, #054E81 0%, #0D5D9A 20%);   
  	background-image:     -ms-linear-gradient(top, #054E81 0%, #0D5D9A 20%);   
  	background-image:      -o-linear-gradient(top, #054E81 0%, #0D5D9A 20%);   
  	background-image:         linear-gradient(to bottom, #054E81 0%, #0D5D9A 20%);
}
.logintable input[type=text],input[type=password] {
    background-color: #E0EDF3;
    border: 1px solid #035793;
}
.logintable input[type=submit] {
    padding: 3px 5px;
    height : 35pt;
    width  : 35pt;
    border : medium none;
}
.logintable tr td:nth-child(1) {
	width : 50px;
	text-align: right;
}
.logintable tr td:nth-child(2) {
	text-align : left;
}
.logintable tr td:nth-child(3) {
	width : 60px;
	text-align: center;
	vertical-align: middle;
}
.logintable tr:nth-last-child(2) td {
	text-align: center;
}
.logintable tr:nth-last-child(1) td {
	text-align: right;
}
/* For browser hint */
.browser-hint {
	    display : none;
}
.ie6 .browser-hint {
         z-index : 2;
           width : 450px;
          height : 95px;
          display: block;
	    position : absolute;
	         top : 0px;
	        left : 50%;
	 margin-left : -225px;
	  text-align : center;
background-color : #FEF9D0;
}
.browser-link {
	height : 60px;
	width  : 60px;
	text-align : center;
}
.browser-link a {
	display : block;
	height  : 60px;
	width   : 60px;
	margin-left : 30px;
}
.chrome {
	background : url("${base}/static/images/browsers/chrome-60x60.png") no-repeat scroll 0 0 transparent;
}
.firefox {
	background : url("${base}/static/images/browsers/firefox-60x60.png") no-repeat scroll 0 0 transparent;
}
.iexplorer {
	background : url("${base}/static/images/browsers/ie-60x60.png") no-repeat scroll 0 0 transparent;
}
</style>

<table class="browser-hint" align="center">
	<tr>
		<td colspan="3">
			请使用IE7(或以上版本)、Firefox或Google Chrome浏览器访问本系统<br>
			否则可能影响功能使用
		</td>
	</tr>
	<tr>
		<td class="browser-link">
			<a class="iexplorer" href="http://www.microsoft.com/windows/internet-explorer" target="_blank"></a>
		</td>
		<td class="browser-link">
			<a class="firefox" href="http://www.mozilla.com" target="_blank"></a>
		</td>
		<td class="browser-link">
			<a class="chrome" href="http://www.google.com/chrome" target="_blank"></a>
		</td>
	</tr>
</table>


[#if ((Session['loginFailureCount'])?default(0)>1)][#assign needCaptcha=true][#else][#assign needCaptcha=false][/#if]
<div class="logindiv">
	<h1>财务管理系统</h1>
	[@b.form name="loginForm" action="login" target="_top"]
		<table class="logintable">
			<tr>
				<td colspan="3">[@b.messages/]</td>
			</tr>
			<tr>
				<td><label for="username">用户名:</label></td>
				<td>
					<input name="username" id="username" tabindex="1" title="请输入用户名" type="text" value="${name!}" style="width:95px;"/>
				</td>
				<td rowspan="2">
					[@b.submit name="submitBtn" tabindex="6" class="button-s" value="登录" onsubmit="checkLogin"][/@]
				</td>
			</tr>
			<tr>
				<td>
					<label for="password">密码:</label>
				</td>
				<td>
					<input id="password" name="password"  tabindex="2" type="password" style="width:95px;"/>
					<input name="encodedPassword" type="hidden" value=""/>
				</td>
			</tr>
			[#if needCaptcha]
			<tr>
				<td>
					<label for="captcha">验证码:</label>
				</td>
				<td colspan="2">
					<input id="captcha" name="captcha"  tabindex="3" type="text" style="width:70px;"/>
					<img src="${b.url('security/captcha')}" title="验证码,点击更换一张" onclick="changeCaptcha(this)" alt="验证码" width="60" height="25" style="vertical-align:top;"/>
				</td>
			</tr>
			[/#if]
			<tr>
				<td colspan="3">
					<input name="session_locale" id="local_zh" type="hidden" value="zh_CN" value="1" />
				</td>
			</tr>
			<tr>
				<td colspan="3">
				</td>
			</tr>
		</table>
	[/@]
</div>

<div class="foot"></div>

<script type="text/javascript">
	var form  = document.loginForm;
	
	var user = document.getElementById("username");
	var pwd = document.getElementById("password");
	user.focus();

	function checkLogin(form){
		if(!form['username'].value) {
			art.dialog({ lock: true, opacity: 0.7, content: '用户名不能为空!', icon: 'error', noFn: true, noText: '确定', closeFn: function() { user.focus(); } }); 
			return false;
		}
		if(!form['password'].value) {
			art.dialog({ lock: true, opacity: 0.7, content: '密码不能为空!', icon: 'error', noFn: true, noText: '确定', closeFn: function() { pwd.focus(); } }); 
			return false;
		}
		[#if needCaptcha]
		if(!form['captcha'].value) {
			art.dialog({ lock: true, opacity: 0.7, content: '验证码不能为空!', icon: 'error', noFn: true, noText: '确定', closeFn: function() { form['captcha'].focus(); } }); 
			return false;
		}
		[/#if]
		return true;
	}
	var username=beangle.cookie.get("username");
	if(null!=username){ form['username'].value=username;}
	function changeCaptcha(obj) {
		//获取当前的时间作为参数，无具体意义
		var timenow = new Date().getTime();
		//每次请求需要一个不同的参数，否则可能会返回同样的验证码
		//这和浏览器的缓存机制有关系，也可以把页面设置为不缓存，这样就不用这个参数了。
		obj.src="${b.url('security/captcha')}?d="+timenow;
	}
</script>
[@b.foot/]
