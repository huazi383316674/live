[#ftl]
[@b.head /]
[@b.module title="欢迎信息"]
	<span style="font-size:11pt">尊敬的<b>${userName}</b>，欢迎使用综合生活管理系统v2.0！今天是${date}。</span>
[/@]

[@b.module title="天气预报<span id='citySpan'><span>"]
	<table style="font-size:10pt" width="95%">
   		<tr height="20px"><td id="td_weather1"></td></tr>
   		<tr height="20px"><td id="td_weather2"></td></tr>
   		<tr height="20px"><td id="td_weather3"></td></tr>
   		<tr height="20px"><td id="td_weather4"></td></tr>
	</table>
[/@]

[@b.module title="轻松一刻"]
	<table style="font-size:11pt;" width="95%">
		[#list jokes! as joke]
   		<tr>
			<td style="line-height:22px;">&nbsp;&nbsp;&nbsp;&nbsp;${joke.content}</td>
		</tr>
		[#if joke_has_next]<tr height="10px"></tr>[/#if]
   		[/#list]
  	</table>
[/@]

<script>
	jQuery(function() {
		getWeather();
	})
	
	function getWeather() {
		jQuery.ajax({
			url : 'home!getWeather.action?_='+ new Date().getTime(),
			type : 'GET',
			success : function(data) {
				var dataObj = eval("("+data+")");
				var w = dataObj.weatherinfo;
				jQuery("#td_weather1").html("今天："+w.weather1+"  "+w.temp1+"  <img src='http://www.weather.com.cn/m/i/weatherpic/29x20/d"+w.img1+".gif'></img>  "+ w.wind1);
				jQuery("#td_weather2").html("明天："+w.weather2+"  "+w.temp2+"  <img src='http://www.weather.com.cn/m/i/weatherpic/29x20/d"+w.img3+".gif'></img>  "+ w.wind2);
				jQuery("#td_weather3").html("后天："+w.weather3+"  "+w.temp3+"  <img src='http://www.weather.com.cn/m/i/weatherpic/29x20/d"+w.img5+".gif'></img>  "+ w.wind3);
				jQuery("#td_weather4").html("大后天："+w.weather4+"  "+w.temp3+"  <img src='http://www.weather.com.cn/m/i/weatherpic/29x20/d"+w.img7+".gif'></img>  "+ w.wind4);
				jQuery("#citySpan").html("(" + w.city + ")");
			}
		});
	}
</script>
[@b.foot/]